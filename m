Return-Path: <linux-kernel+bounces-423327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F089DA5D9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66F6B162872
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5168F197543;
	Wed, 27 Nov 2024 10:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="KPIbMHNZ"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A9918E0E;
	Wed, 27 Nov 2024 10:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732703624; cv=none; b=oHIKVCZ6F7u/R2h2ddQd3avomrgjve+X1MzvOVOLYAozvbPBg7VynswmiGEV0t9lda/7dnSyX4kritIfKjtx6Oa2Z4yEy+sqcL6f+KRiiWDSh4VV7rcBH1/4c3kYIWK4kdUhWCQCftcyasiG1VT98AV/kaqdYBraqiuLQdofPNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732703624; c=relaxed/simple;
	bh=8/YvfhoMhG4lnS0ZRcJnPEcwxuLXFtnWSdEqlHzI6Bs=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=E1kKlPctSVRzX5h7P7d/ws+4mUrFAYBzihLbxc33IqBKnXb9UwC4iwgIjzYn1IFUVduNWrhjhnAQRure0QdvaE8vRVLsPNjbmibrQNRuN0ZBEZnc76MlSC82rvlTCOdTVKR+UKPovZ9eWuzLVIburqm2CLjFiE3nWtgBqMtPtNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=KPIbMHNZ; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1732703607; x=1733308407; i=frank-w@public-files.de;
	bh=Gui8XtOnRhwfSfn8amV6rgpKsWF09Hk0EX9whY3POKs=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:In-Reply-To:References:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KPIbMHNZoioul2frRFk8AOmMqOsOo32BdYVNkXzHMgxGdKDHwAxIPpZwaVPmTjbQ
	 DKtPhxJvI0OkdKBbbH/3+zJ7YsJ71vA3ee0ApL1Ydc3jOSH98M6SWauPu91NGQB9i
	 Wa/Ch8omGnoTqaNjicVjU66mJK0cYrsB9HhI2s0hsAMfRYhi+p10wzyBw2EYgZHlv
	 WhqdHMuW/lhkL6xjcV47rN+ZiUcFNcbHeknAOKLvGFxMRY/ZP5Pg0daKdZSNwX2Su
	 XWUueIRpKd8SbokcFl5khCzup5MoxIxqTrgP81uMZveP3fNzOW+qxAZCYFfy9C2g0
	 tE5/qoKf7yFw6mkejQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [157.180.224.21] ([157.180.224.21]) by
 trinity-msg-rest-gmx-gmx-live-5cd5dd5458-9xbqt (via HTTP); Wed, 27 Nov 2024
 10:33:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-8a99bc44-538d-4d16-90f5-3c3844ca0daf-1732703607019@trinity-msg-rest-gmx-gmx-live-5cd5dd5458-9xbqt>
From: Frank Wunderlich <frank-w@public-files.de>
To: linux@fw-web.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Aw: [RFC v1 00/14] Add some mt7988 DTS labels and new nodes
Content-Type: text/plain; charset=UTF-8
Importance: normal
Date: Wed, 27 Nov 2024 10:33:27 +0000
Sensitivity: Normal
In-Reply-To: <20241029103937.45852-1-linux@fw-web.de>
References: <20241029103937.45852-1-linux@fw-web.de>
X-Priority: 3
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:W9g3hUVnLQDmyZ0+hTVVrL0XxLF4xD28aBulqWmq+BNV4tBHhfm6ktQHlmCjxlrStrOoy
 C5cnUri43ezy6bSapCcvtCBaphop698DCA2wmcz98CK/NHSwBVKzhEUN9Au3jBlCqdoH3Fw5gcvx
 LQ6xdGYUy8M+JCJ3Bz1X7YI1q7orDFjKYj9Xq355CF+GbbXNpy272FdO0jP4LtoVXQk49queNq0c
 elwgzH1/pkuhaiN2MzvVS6Q+xti/KzSnhZe1l3EWr3WDi7DQO/qyuqr04xBeSskWJF+9UnExuAMW
 rnWS0DjhceG056qsWqU1UVhH+byK38myG0XZixO1if/whVMUpKCmVG0U4K21IaubiE=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sU6QkSDhW1Y=;C1S+1doWr/0bG56VwSTwb6J837C
 E4sPNGg9LHRSxFtFoF/VEm6wZM0ia888CjW62DaJnLELgFmbuMjIC2xjBr7cyRTduj8Gk/v1S
 SFcD6iZZdg3O2tkUdb3cEhZSczeq0iQ1re9FOQfocQgy45y8pLn9h13dsr2lrntdYYms2k/1u
 esJSz9CFsrEWN9Vw6H78vctK/V1dx2cr1FeAxNM1Y5iAc5m+vPF6yESsU1xKEbus6Gc7NOLyi
 x+COSnSWFGTzV8lR0FNbJ1SpK1MspxhyoFsqatjU5t5bNo6PHufIJIlfLa0E9+v/7rmv4F72i
 ndHicJ09N/T/bh5IF9SJKsw2oa+t1Mxb7YL0cZ7WmepZfBMiCgdOy0nxO51T9NCNIOLZS3XSV
 Wb0hwOSMm3o/1P/qSsSVaZS7kWpaFiySYvJHgtEXqTtnRO74eJIdkqJEBjJkxvepZuWSGHd5+
 21Bs7uEvBIlx4nrnLdETpXUZx0NUTC4Cee0FpIbz4onE53/VUchAji+PDxvz/WXwapOWzB5Oo
 jfadPdD8QC1cg4gAq75h2JIFYtS/4MtYDpUeD6B3osVq0vqa6QnB/ALX/CsklOjz/Ksf5LPdW
 8ljJPGUR5VdK/9orxu8c0a74ACfpJvZJjR9cH8Lx+MH5U2r0kH98wRE4gJtna53oIdZIEn3q0
 5BL6hIi6Pmmq5nSfy97lZDWKk9qot0OBwjecn8H8ug==
Content-Transfer-Encoding: quoted-printable

just a gentle ping...any thoughts about it?

should i squash the label-commits or can it applied this way?

btw. the series about mt7986/bpi-r3 is also open till half year...and it w=
as resend too...

https://patchwork.kernel.org/project/linux-mediatek/patch/20240608080530.9=
436-2-linux@fw-web.de/

regards Frank


&gt; Gesendet: Dienstag, 29. Oktober 2024 um 11:39
&gt; Von: "Frank Wunderlich" <linux@fw-web.de>
&gt; An: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@k=
ernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Matthias Brugger" <matt=
hias.bgg@gmail.com>, "AngeloGioacchino Del Regno" <angelogioacchino.delreg=
no@collabora.com>
&gt; CC: "Frank Wunderlich" <frank-w@public-files.de>, devicetree@vger.ker=
nel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.or=
g, linux-mediatek@lists.infradead.org
&gt; Betreff: [RFC v1 00/14] Add some mt7988 DTS labels and new nodes
&gt;
&gt; From: Frank Wunderlich <frank-w@public-files.de>
&gt;
&gt; This series adds some missing labels and new nodes to mt7988 DTS.
&gt;
&gt; If wanted i can squash the coommits adding labels to have less patche=
s,
&gt; but for first review i let them separate.
&gt;
&gt; Frank Wunderlich (14):
&gt;   arm64: dts: mediatek: mt7988: add missing label for apmixedsys
&gt;   arm64: dts: mediatek: mt7988: add labels for i2c nodes
&gt;   arm64: dts: mediatek: mt7988: add labels for usb nodes
&gt;   arm64: dts: mediatek: mt7988: add serial labels
&gt;   arm64: dts: mediatek: mt7988: add label for pwm node
&gt;   arm64: dts: mediatek: mt7988: add label for efuse
&gt;   arm64: dts: mediatek: mt7988: add mmc support
&gt;   arm64: dts: mediatek: mt7988: add fixed regulators for 1v8 and 3v3
&gt;   arm64: dts: mediatek: mt7988: extend efuse node
&gt;   arm64: dts: mediatek: mt7988: add lvts node
&gt;   arm64: dts: mediatek: mt7988: add thermal-zone
&gt;   arm64: dts: mediatek: mt7988: add reserved memory
&gt;   arm64: dts: mediatek: mt7988: add mcu-sys node for cpu
&gt;   arm64: dts: mediatek: mt7988: add operating-points
&gt;
&gt;  arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 196 ++++++++++++++++++++=
=2D-
&gt;  1 file changed, 181 insertions(+), 15 deletions(-)
&gt;
&gt; --
&gt; 2.43.0
</frank-w@public-files.de></frank-w@public-files.de></angelogioacchino.del=
regno@collabora.com></matthias.bgg@gmail.com></conor+dt@kernel.org></krzk+=
dt@kernel.org></robh@kernel.org></linux@fw-web.de>

