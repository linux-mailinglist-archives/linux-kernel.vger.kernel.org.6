Return-Path: <linux-kernel+bounces-428126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E589E0A77
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 542A616282F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2281DC197;
	Mon,  2 Dec 2024 17:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="XwANpcta"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F325B1DB548;
	Mon,  2 Dec 2024 17:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733162092; cv=none; b=aJ9ssS1jNg2HEK5i0CP6m9B6f+ZhWZFjGFGgR8ouR/inGojAoSDqWADZWQR1KHX3LM9GLw0jevHJ2nH2jp2ZIRcncgzNR6YDfD0puhp1FKXpJ9ncpA3ekhiCCKjFUzclXbcDpJO1ml4bFJILhuRwxTRqgXIoi8GP2ZuhBMKAk50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733162092; c=relaxed/simple;
	bh=zRrOHULAoebGdJ5prrzDJgNzQmrKGcIm1PL6bsLvO0c=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:
	 In-Reply-To:References:Date; b=UAY7SdQbDmFyNALt/19+/Xd001YCq93jL6DOHf9Kb67/NThoe7SV85YetOrLUa7N4wGlT8gWCLrgCOAark6GxQ0k75r+lHN7Ebec40zmXnvLedfAxCxuUprCS69nZiJhFR2egKsVtqX/ocgigep6ldQU1vniXYlOeAkQt3I3Xf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=XwANpcta; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1733162075; x=1733766875; i=frank-w@public-files.de;
	bh=csQeuHYg2kZNLaDRCcKsFmv4O0a8VhN4DqF2quOR8hs=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:In-Reply-To:References:Date:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XwANpctaXsGrumeeDin4SUTd3kX/sicp8aqf4UJ/qpkBnM9AE97PwY8py6qAkHwq
	 JoPmDANipdE1SVPj+OZRWnFmf5XY7Ln6RZbMagpIYNDvCAWatUBeHOuxet/pHlvDl
	 xAowS4ZE/RcUODCwIOwYz5lyv1jyHxT8hPrijJOVf3V+yqiGSSC8Xy6OYvJNlbbc1
	 dvpJIaMeeuH+4mHh1LKlcnUZ4x39Pwvexl7rHjKvIYbSSUWTtrkODlweY688ZgZiy
	 H1Ivk3ES1lZ0Ppg5RxQtH8pJfjdcTtaVrLYQQkd28+/jGsi7UfYYhVXItZwaI5jnl
	 1pRT6Se6bWJuaPke9Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.149.104] ([217.61.149.104]) by
 trinity-msg-rest-gmx-gmx-live-5cd5dd5458-t4xzg (via HTTP); Mon, 2 Dec 2024
 17:54:35 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-1c2ce600-fa6d-485e-93ee-1b66b6cf4939-1733162074956@trinity-msg-rest-gmx-gmx-live-5cd5dd5458-t4xzg>
From: Frank Wunderlich <frank-w@public-files.de>
To: krzk@kernel.org, linux@fw-web.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Aw: Re: [PATCH v2 11/18] arm64: dts: mediatek: mt7988: add chosen
 node on bpi-r4
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <e1343cc5-d5e8-40d6-a6f1-3eaf22a8cd6d@kernel.org>
Importance: normal
References: <20241202122602.30734-1-linux@fw-web.de>
 <20241202122602.30734-12-linux@fw-web.de>
 <0fb58a4a-7bad-4623-99c8-67f5763558bb@kernel.org>
 <D92CAF3C-F6B7-46DC-BF83-A71907E2D7EA@fw-web.de>
 <e1343cc5-d5e8-40d6-a6f1-3eaf22a8cd6d@kernel.org>
Date: Mon, 2 Dec 2024 17:54:35 +0000
Sensitivity: Normal
X-Priority: 3
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:wapAPyeB/C9J/AfnRZDwNydyVTVve8Sqeg8lWJg6SWcqV+p/uH8rIefi7WPlQwZkrewTV
 yRp0UIq4OGmLXtfKz64W8L3LL9UvVsIjDD1/ZkY4rSQk9xc7hZ221QIaFn8MA9zNzhq+loeCpArB
 GZq2Lfzu8kLtE4UDUC2zGeaaoK5YbsXhEe5TuZz2xWJ9zNf2sBdrJwtGzrQtOT1gvGqeWwckWnzd
 /7lpvyKQRMOvy9uhSQ6+QBuzr+ubUFi8btoqrzmnkncewKjadOs9/aHdTUcYy3lOUkoHG4EnzwGd
 mB9NkZUqsOoqQ0HjxEJybM/aYJeBWngwtqqBvjl4VVptwD+MjBC8Pw6uM+BHzq2E/c=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gh0nr7QtLMo=;TEJMAFcHDn71LQYYAem+XyUN1AZ
 jmswZ2o9xneClWgIkkBwrE5RPHVANtznA9sDDZC8niFOE+vLIxQWp9siJxZ6PegJWzZzz8U1w
 bamCd7l47a8MVbPxeALfMc222n0qjZ+h1NZh/5Pid3XHBwaUfKk6koQrD2nxhpJBz9Sz1Ug6+
 piHWku+B2G3L0ATtF1i5pROi4qLOENJLnFVPZUJo1+UoLszor+ja8csJpYtFfgewXWhfkA2+u
 2rL/q356Z2s1KmZanXuTCNWILf8t4CKaqgOdcIyWAeo9gBdbNiRox1FR2EghOWRZK3tWR76sp
 h/MOFctJKtpz8qwHsDhcCSixGILI/D3sWpyLvTLCL/o+g1++2LmYQS7v9UqSG7tg3pyuNKF3O
 HSJ5M0g5ji1fKlonSDPzZ8edPVs17xTi2QRMA7wBcpOCbgdHPN3C1twBt//YlSUJzC17giqwZ
 9ytBJQU9OMZXktzO1kckGBQi6EoArfo3weALQVHk6T/Hs+/vD3MlVX78RJZNub/97h5+pAJJE
 osB2JfUehZm4NN9d+A7swiDIBh0eXS20olUTA2VtlAZtLTytQzI3Kn4rqLB0YvIAVIkiwP64k
 iQz7hD1xmJNVmW6f+wn+UI9WctskDoCDj2VFKrZ0WIzIvM6m3mxmHgXdXNBjW7sgMXF1fnLA+
 YfcUshNA/84dXYjVHRWrAYDjO5x5b/XL1Z7HFDJEdOVjYO/rz+bMbE0wWKe25j7VEWU9nw2Xl
 ErrOAaUDruOgJS/B43aZOAo2hLZZKWcZxGdfI7upKyjkeQhTd4Wopcxwd3NMsBnyYe+CViC6i
 ZDIPZKogBq6Qxvej5hUKW+dBWUR7Rr69IJixEXNYHiwzaHgRS38EB9zjeEOwWcCfwkXmKfN+K
 6Z9l9LaOexUYQAfQizQwElzQj+lHqY0NrQnc=
Content-Transfer-Encoding: quoted-printable

regards Frank


&gt; Gesendet: Montag, 2. Dezember 2024 um 16:58
&gt; Von: "Krzysztof Kozlowski" <krzk@kernel.org>
&gt; An: "Frank Wunderlich" <linux@fw-web.de>, "Rob Herring" <robh@kernel.=
org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt=
@kernel.org>, "Matthias Brugger" <matthias.bgg@gmail.com>, "AngeloGioacchi=
no Del Regno" <angelogioacchino.delregno@collabora.com>
&gt; CC: "Frank Wunderlich" <frank-w@public-files.de>, devicetree@vger.ker=
nel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.or=
g, linux-mediatek@lists.infradead.org
&gt; Betreff: Re: [PATCH v2 11/18] arm64: dts: mediatek: mt7988: add chose=
n node on bpi-r4
&gt;
&gt; On 02/12/2024 15:29, Frank Wunderlich wrote:
&gt; &gt; Am 2. Dezember 2024 14:46:24 MEZ schrieb Krzysztof Kozlowski <kr=
zk@kernel.org>:
&gt; &gt;&gt; On 02/12/2024 13:25, Frank Wunderlich wrote:
&gt; &gt;&gt;&gt; From: Frank Wunderlich <frank-w@public-files.de>
&gt; &gt;&gt;&gt;
&gt; &gt;&gt;&gt; Add chosen node on Bananapi R4 board with stdout and def=
ault bootargs.
&gt; &gt;&gt;&gt;
&gt; &gt;&gt;&gt; Signed-off-by: Frank Wunderlich <frank-w@public-files.de=
>
&gt; &gt;&gt;&gt; ---
&gt; &gt;&gt;&gt;  arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dt=
s | 5 +++++
&gt; &gt;&gt;&gt;  1 file changed, 5 insertions(+)
&gt; &gt;&gt;&gt;
&gt; &gt;&gt;&gt; diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-banana=
pi-bpi-r4.dts b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
&gt; &gt;&gt;&gt; index 9037f35857a9..1c2a806f6f6c 100644
&gt; &gt;&gt;&gt; --- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-=
r4.dts
&gt; &gt;&gt;&gt; +++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-=
r4.dts
&gt; &gt;&gt;&gt; @@ -9,6 +9,11 @@ / {
&gt; &gt;&gt;&gt;  	model =3D "Banana Pi BPI-R4";
&gt; &gt;&gt;&gt;  	chassis-type =3D "embedded";
&gt; &gt;&gt;&gt;
&gt; &gt;&gt;&gt; +	chosen {
&gt; &gt;&gt;&gt; +		stdout-path =3D &amp;serial0;
&gt; &gt;&gt;&gt; +		bootargs =3D "console=3DttyS0,115200n1";
&gt; &gt;&gt;
&gt; &gt;&gt; Drop or merge into stdout path.
&gt; &gt;
&gt; &gt; Have you an example to pass speed setting to stdout-path? As it =
is only a phandle it is not clear to me how to merge these 2...
&gt; It is really trivial to find, considering that 66% of files have it.
&gt;
&gt; git grep stdout

thanks, wasn't aware that string is here also accepted...found it ("git gr=
ep stdout-path" is much better here :) )

will change both lines to this single one:

stdout-path =3D "serial0:115200n8";

&gt; Best regards,
&gt; Krzysztof
&gt; </frank-w@public-files.de></frank-w@public-files.de></krzk@kernel.org=
></frank-w@public-files.de></angelogioacchino.delregno@collabora.com></mat=
thias.bgg@gmail.com></conor+dt@kernel.org></krzk+dt@kernel.org></robh@kern=
el.org></linux@fw-web.de></krzk@kernel.org>

