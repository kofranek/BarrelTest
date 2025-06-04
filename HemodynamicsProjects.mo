within ;
package BarrelTest
  package Parts
    model HydraulicBarrel
      Bodylight.Types.RealIO.VolumeInput V "volume in barrel" annotation (Placement(
            transformation(extent={{-198,16},{-158,56}}), iconTransformation(extent
              ={{-114,46},{-84,76}})));
      Bodylight.Types.RealIO.PositionInput d "barrel width " annotation (Placement(
            transformation(extent={{-198,-6},{-158,34}}), iconTransformation(extent
              ={{-110,-30},{-80,0}})));
      Bodylight.Types.RealIO.PositionOutput h "level height" annotation (Placement(
            transformation(extent={{-188,54},{-168,74}}), iconTransformation(extent
              ={{100,60},{124,84}})));
      Bodylight.Types.RealIO.PressureOutput P "hydraulic pressure" annotation (
          Placement(transformation(extent={{-188,20},{-168,40}}),
            iconTransformation(extent={{100,20},{124,44}})));
      Types.HydraulicElastanceOutput el "hydraukic elastance" annotation (Placement(
            transformation(extent={{-188,26},{-168,46}}), iconTransformation(extent
              ={{100,-20},{120,0}})));
      Bodylight.Types.Area S; //Aurface area of barrel
      parameter Bodylight.Types.Density ro=1060; //blood density in kg/m3=g/l
      parameter Bodylight.Types.Position l=0.1; //base length 10 cm
      parameter Bodylight.Types.Acceleration g = Modelica.Constants.g_n;// gravitation constant m/sec2
    equation
      S=d*l;
      V=h*S;
      P=ro*h*g;
      el=P/V;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={28,108,200},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid), Text(
              extent={{-116,-108},{122,-118}},
              textColor={28,108,200},
              textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false)));
    end HydraulicBarrel;

    model HydraulicBarrelWithHydraulicPort
      Bodylight.Types.RealIO.VolumeInput Vinit "initial volume in barrel"
                                                              annotation (Placement(
            transformation(extent={{-198,16},{-158,56}}), iconTransformation(extent
              ={{-114,46},{-84,76}})));
      Bodylight.Types.RealIO.PositionInput d "barrel width " annotation (Placement(
            transformation(extent={{-198,-6},{-158,34}}), iconTransformation(extent
              ={{-110,-30},{-80,0}})));
      Bodylight.Types.RealIO.PositionOutput h "level height" annotation (Placement(
            transformation(extent={{-188,54},{-168,74}}), iconTransformation(extent
              ={{100,60},{124,84}})));
      Bodylight.Types.RealIO.PressureOutput P "hydraulic pressure" annotation (
          Placement(transformation(extent={{-188,20},{-168,40}}),
            iconTransformation(extent={{100,20},{124,44}})));
      Types.HydraulicElastanceOutput el "hydraukic elastance" annotation (Placement(
            transformation(extent={{-188,26},{-168,46}}), iconTransformation(extent
              ={{100,-20},{120,0}})));
      Bodylight.Types.Area S; //Aurface area of barrel
      parameter Bodylight.Types.Density ro=1060; //blood density in kg/m3=g/l
      parameter Bodylight.Types.Position l=0.1; //base length 10 cm
      parameter Bodylight.Types.Acceleration g = Modelica.Constants.g_n;// gravitation constant m/sec2
      Bodylight.Hydraulic.Interfaces.HydraulicPort_a inflow
        "inflow hydraulic connector" annotation (Placement(transformation(extent={{-188,
                40},{-168,60}}), iconTransformation(extent={{-14,-110},{6,-90}})));
      Bodylight.Types.Volume V;
    initial equation
      V=Vinit;
    equation
      S=d*l;
      V=h*S;
      P=ro*h*g;
      el=P/V;
      der(V) = inflow.q;
      P=inflow.pressure;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={28,108,200},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid), Text(
              extent={{-116,-108},{122,-118}},
              textColor={28,108,200},
              textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false)));
    end HydraulicBarrelWithHydraulicPort;
  end Parts;

  package Tests
    model HyraulicBarrelTest
      Parts.HydraulicBarrel hydraulicBarrel
        annotation (Placement(transformation(extent={{-12,10},{18,40}})));
      Bodylight.Types.Constants.VolumeConst volume(k=0.003)
        annotation (Placement(transformation(extent={{-68,36},{-60,44}})));
      Bodylight.Types.Constants.PositionConst width(k(displayUnit="cm") = 0.2)
        annotation (Placement(transformation(extent={{-68,12},{-60,20}})));
      extends Modelica.Icons.Example;
    equation
      connect(volume.y, hydraulicBarrel.V) annotation (Line(points={{-59,40},{
              -22,40},{-22,34.15},{-11.85,34.15}}, color={0,0,127}));
      connect(width.y, hydraulicBarrel.d) annotation (Line(points={{-59,16},{
              -22,16},{-22,22.75},{-11.25,22.75}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end HyraulicBarrelTest;

  end Tests;

  package Models
    model HyraulicBarrel
      Parts.HydraulicBarrel hydraulicBarrel
        annotation (Placement(transformation(extent={{-12,10},{18,40}})));
      Bodylight.Types.Constants.VolumeConst volume(k=0.003)
        annotation (Placement(transformation(extent={{-68,36},{-60,44}})));
      Bodylight.Types.Constants.PositionConst width(k(displayUnit="cm") = 0.2)
        annotation (Placement(transformation(extent={{-68,12},{-60,20}})));
      extends Modelica.Icons.Example;
    equation
      connect(volume.y, hydraulicBarrel.V) annotation (Line(points={{-59,40},{
              -22,40},{-22,34.15},{-11.85,34.15}}, color={0,0,127}));
      connect(width.y, hydraulicBarrel.d) annotation (Line(points={{-59,16},{
              -22,16},{-22,22.75},{-11.25,22.75}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end HyraulicBarrel;
  end Models;

  package Types
    connector HydraulicElastanceInput = input
        Bodylight.Types.HydraulicElastance
      "input HydraulicElastance as connector"
      annotation (defaultComponentName="hydraulicelastance",
      Icon(graphics={Polygon(
              points={{-100,100},{100,0},{-100,-100},{-100,100}},
              lineColor={0,0,127},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid)},
           coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, initialScale=0.2)),
      Diagram(coordinateSystem(
            preserveAspectRatio=true, initialScale=0.2,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={Polygon(
              points={{0,50},{100,0},{0,-50},{0,50}},
              lineColor={0,0,127},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid), Text(
              extent={{-10,85},{-10,60}},
              lineColor={0,0,127},
              textString="%name")}),
        Documentation(info="<html>
    <p>
    Connector with one input signal of type HydraulicCompliance.
    </p>
    </html>"));
    connector HydraulicElastanceOutput = output
        Bodylight.Types.HydraulicElastance
      "output HydraulicElastance as connector"
      annotation (defaultComponentName="hydraulicelastance",
      Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={Polygon(
              points={{-100,100},{100,0},{-100,-100},{-100,100}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
      Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={Polygon(
              points={{-100,50},{0,0},{-100,-50},{-100,50}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid), Text(
              extent={{30,110},{30,60}},
              lineColor={0,0,127},
              textString="%name")}),
        Documentation(info="<html>
  <p>
  Connector with one output signal of type Real.
  </p>
  </html>"));
  end Types;
  annotation (uses(Bodylight(version="1.0"), Modelica(version="4.0.0")));
end BarrelTest;
