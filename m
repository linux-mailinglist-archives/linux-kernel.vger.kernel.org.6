Return-Path: <linux-kernel+bounces-243747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38537929A04
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 00:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68E301C20B6F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 22:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659D076046;
	Sun,  7 Jul 2024 22:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b="jVyXEVYh"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F1712E55;
	Sun,  7 Jul 2024 22:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720391861; cv=none; b=q7NSEBFWzX/lIhNPNO6g9orzFQPlkIkv8MaPH4Fv/vLvAQuIwAvzV6NI3z54q+NQZi8YGPPMbSIm/Vyp7vBGgSOhiVHHlYf8cu/gGuj90oYxi7cmaoHMcj/zaVBvlM1Mv+muGqnmn3Fu9zvGjrxnbAWysmRo6f+5MhXWmPagWn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720391861; c=relaxed/simple;
	bh=bdyAkeRgqSrFufI3kQJoEmI1WCv8IK5atLvcmX85qw4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z3aRO+pXcwdPz44syqJFaT28WwZJ0eZinNpJckB+HnTvneXmsD0XAe6BR621+HsKsfqv34LUBlDbQqIaYPFvS7/okGQ5W6qvsHmsrlZNDyAC1Prw7N/ER0AVCSgLY06HzeEYL6nX7VtE11JrSKrf4PZA469JhN3zA/upxPcQhqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b=jVyXEVYh; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1720391852; x=1720996652; i=j.neuschaefer@gmx.net;
	bh=z1H4srJHNcb5BIAMp3q2n7Fh/jbh0k/UyMAjnW8Y9nc=;
	h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jVyXEVYh9k+5K3xWF1tJWiv0ju5M+RNKgO13mM8RlP3Zi5vN2u/Ny/B5/tPeSt+M
	 E7hH/AKG77ktCva2eNQIkPtw6d/ZyMcFllHduI1OqxrJTiEo+N33DZHkq7GlHOaHa
	 0eFGxfjAgC7iB20JdJVd7onXWRFB8jSVavB9K2sswymOY8yGcFqkylp5Qrdf8Yipb
	 ZfWKrAkSpeAaqLmpfiDrabV8M6cyx3r7h9nN9wbgnbjG1wyzxOBzmx2ww8LQN1JOx
	 kgNPYXgIzgWVe70EVd4/TmmZQ0yZ5R4kehsYKLJfCxRrgc8LxuTF7nrTg2awEh3fg
	 T9qjQOjxr15x6SHUVw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([89.0.46.161]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvbBk-1s9keA2oCc-00qpW4; Mon, 08
 Jul 2024 00:37:32 +0200
From: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Date: Mon, 08 Jul 2024 00:37:18 +0200
Subject: [PATCH RESEND v12 5/6] ARM: dts: wpcm450: Remove
 clock-output-names from reference clock node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20240708-wpcm-clk-v12-5-1afac539c37d@gmx.net>
References: <20240708-wpcm-clk-v12-0-1afac539c37d@gmx.net>
In-Reply-To: <20240708-wpcm-clk-v12-0-1afac539c37d@gmx.net>
To: openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720391846; l=1382;
 i=j.neuschaefer@gmx.net; s=20240329; h=from:subject:message-id;
 bh=gdIaqrhURYiTo/eMHHjfcL4TfUOiwQNCqwm1DTjUKA4=;
 b=opf9v32Sws5pkjzmle/zmPH0T6J5tAXRIPhX3SX0G/L71lfZNKxZQwrecdqPWCtrzMJ8ekU4G
 gayPXFZZmnwAgUib+4MDTO3xE9LqdRHKitDyqUmK7RYzA3T/UVQSL7H
X-Developer-Key: i=j.neuschaefer@gmx.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Provags-ID: V03:K1:RQpISCn6aOf7LCNA9lQHMIFbkg0Dff9noFfqlN0uJ0LBMnDouMT
 dpwEHHSTs1Bohk38eniFa30g/i5zRjG1sWM303An0AvwMBpPVIzgpDrA7QH1bUzDRMYVXOX
 Q7djW8qyrHY5wL7ZfnAxeplT/gSy1RJYKVVbSUSATJx8N3qXTeUZ//X2hn4jBnnT6qlUmI/
 ugCBB8zyZVtb2gE4NFVjg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:C4M/FcRkw8E=;OqTlHsdAkBraDNNZtz7uDhR7NyO
 uecl7IR/UXUF1VinGwD+lLY+pHHZ6Ef0ALinTlCu8JoTBDld3Zse/6sbORh1ptjkVKfrrHRnO
 7ZAsN0PZIIDFY5wFcHIhwR58Bu7ohY75twlnuOrPf8yo8nT/kyvT+eqswOp8VG2NGO8qINlWY
 4GMt1T8l9V4kB8oXCiizhcysGIsk53fmvAPZPSeryDvhN31b6LeIXTAcfoy5mAfuSJpqXLk9c
 0yXzsN7fjkBfI3AjQaGg6MluD5J8Wxr9XZN0M6h03fav72pgDj3A2X0h4iGj8vnksDSZRdx01
 oiwdtg0J6xwFCSJ6P+0sAWb3Nz0i1ZFLCiIYvy3EifCbp/JPMVqar7IslYEDcCsCfjRrTTK2X
 SX7WFSx5P6HDp8y1WtaefG2pcMHe6sJwPkOi+2AtWjqyWsVmzPAC4GGfCcYa/vtRbtuyDpsw+
 Rm+qs+nkt16V6ClJ/b0GjWwg64IcKfEH6bXNFso53Rgjcc7hwe5adXCDQXKbxtXjgQQBbFjGI
 sOV9D+UJI6DsE+vsrCNFXNK1IBvi2ob2eaR2V+0pTiCtBzibi1yKRYiZJSlyUnkpCWoZR61FQ
 kuPgouYbCOI/FoUhJYkzwOBdibC/TRLBI3Cs+eWKz/8qSnMsNbMngrErFT6I/05++emJTbm1A
 gIHxellQqSIqqEJFoh8aSKV6HfAflVCngyY9k+XbXxMBQcg2guXOzsipuem7wDeq5Uj9MZrbG
 GCTVMkvPBZ4iUHgNmVX7dSebPTPlzpBw3ZUOehT7OatedL/hGW7hKtQTcBCw8skx3ijco+I2i
 Hl8Ccp5SZ9U/18e8Hlh6+h4Xo47qU38vUEmWpWnQZMoSA=

A previous version of the as-yet unmerged clk-wpcm450 driver[1] used the
output name, but in the current iteration it doesn't rely on it anymore.
Thus it can be removed from the devicetree.

Preserve the "reference" naming aspect in the node name instead.

[1]: Added in "clk: wpcm450: Add Nuvoton WPCM450 clock/reset controller dr=
iver"

Fixes: 362e8be2ec04a6 ("ARM: dts: wpcm450: Add clock controller node")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v12:
- rename node to clock-ref, because it isn't necessarily 48MHz, just by
  board design recommendation

v11:
- Specify since when clock-output-names is unnecessary

v10:
- no changes

v9:
- New patch
=2D--
 arch/arm/boot/dts/nuvoton/nuvoton-wpcm450.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-wpcm450.dtsi b/arch/arm/boo=
t/dts/nuvoton/nuvoton-wpcm450.dtsi
index 6e1f0f164cb4f5..ff153858801ccf 100644
=2D-- a/arch/arm/boot/dts/nuvoton/nuvoton-wpcm450.dtsi
+++ b/arch/arm/boot/dts/nuvoton/nuvoton-wpcm450.dtsi
@@ -37,10 +37,9 @@ clk24m: clock-24mhz {
 		#clock-cells =3D <0>;
 	};

-	refclk: clock-48mhz {
+	refclk: clock-ref {
 		/* 48 MHz reference oscillator */
 		compatible =3D "fixed-clock";
-		clock-output-names =3D "ref";
 		clock-frequency =3D <48000000>;
 		#clock-cells =3D <0>;
 	};

=2D-
2.43.0


