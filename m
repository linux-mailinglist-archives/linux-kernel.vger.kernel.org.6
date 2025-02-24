Return-Path: <linux-kernel+bounces-528075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B49E0A4133B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 03:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FF8F3B0FE1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 02:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD6719D897;
	Mon, 24 Feb 2025 02:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="1iP7C4dP";
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="1iP7C4dP"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BCFEED6;
	Mon, 24 Feb 2025 02:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740363159; cv=none; b=bFg2vzsMPaLfzauOkHB5FDKL4IsydTW8kxBkJ3+Kbx+xT+juPkAt/tSpcLBGpy2fLKeH8QIu+53FU+ikYU18brxJ/8ijxXoQZK82PWJH93YvHEray9AnPxTsnsYZEC1mBCafHGBrVwsSGCtChy6z8tffF96goqer+qUaZVhT2Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740363159; c=relaxed/simple;
	bh=rxrn8+mXf3oIIANnvwxnu4UhXSDU9zD/XTyconO2D4w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/NnKQmKUdQT+B9oaAeGpnL91OTXA0ZVeVodHqSnSOFHJeiL8mfbvBlgyHr2KoDDmnCfXYx5YXdZIeaiA/AM4QnU+i247bcLliMNlInTnQ7nGcyebUiHEArtreKOB8qGMxIee43yJ0YW5d0WqOTnRYwkQaRPHgxvjFbsKV9jnYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=1iP7C4dP; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=1iP7C4dP; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1740363153;
	bh=O4XcWHCpu3h5aG5qDaO09ZjwT9M3Yei0zyY4/p0jwJk=; l=1858;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=1iP7C4dPzmb7E65xMTxqUtTvbhgGeugBVpLObDu8L+USH+xxGCPqex4MRXUY8GsJK
	 g89kf4GuX26r/gukAvox7hpgUIWBHxtM76lrDqHNVEIvdRgOEv3YpiqOX8UjtPVIOf
	 oalHVbKfUcw05JHBXifueBVb0iqvrou8X6G1rwbJPTPDow4IX2t5bhwKufCQr+QknE
	 7Gf7ZvohlAwxlf5qFxekUFUVEPnmFC5MqHi24xHRWnyaaUQftXSD44QHJ3/uiJBqcX
	 NlWJjEqrJCGfmr0PuTo3n/EmYaZI2U+Q4W6KbxBEGYoUYzyTFM/j2wRLmInsX8Zs6D
	 OpZwFwUsiMk4Q==
Received: from 192.168.8.21
	by mg.richtek.com with MailGates ESMTP Server V3.0(1128077:0:AUTH_RELAY)
	(envelope-from <prvs=114923349E=cy_huang@richtek.com>); Mon, 24 Feb 2025 10:12:33 +0800 (CST)
X-MailGates: (compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1740363153;
	bh=O4XcWHCpu3h5aG5qDaO09ZjwT9M3Yei0zyY4/p0jwJk=; l=1858;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=1iP7C4dPzmb7E65xMTxqUtTvbhgGeugBVpLObDu8L+USH+xxGCPqex4MRXUY8GsJK
	 g89kf4GuX26r/gukAvox7hpgUIWBHxtM76lrDqHNVEIvdRgOEv3YpiqOX8UjtPVIOf
	 oalHVbKfUcw05JHBXifueBVb0iqvrou8X6G1rwbJPTPDow4IX2t5bhwKufCQr+QknE
	 7Gf7ZvohlAwxlf5qFxekUFUVEPnmFC5MqHi24xHRWnyaaUQftXSD44QHJ3/uiJBqcX
	 NlWJjEqrJCGfmr0PuTo3n/EmYaZI2U+Q4W6KbxBEGYoUYzyTFM/j2wRLmInsX8Zs6D
	 OpZwFwUsiMk4Q==
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3140694:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Mon, 24 Feb 2025 09:53:29 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 24 Feb
 2025 09:53:28 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Mon, 24 Feb 2025 09:53:28 +0800
Date: Mon, 24 Feb 2025 09:54:26 +0800
From: ChiYuan Huang <cy_huang@richtek.com>
To: Macpaul Lin =?utf-8?B?KOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	Alexandre Mergnat <amergnat@baylibre.com>, "fparent@baylibre.com"
	<fparent@baylibre.com>, Bear Wang =?utf-8?B?KOiQqeWOn+aDn+W+tyk=?=
	<bear.wang@mediatek.com>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, "macpaul@gmail.com"
	<macpaul@gmail.com>, Pablo Sun =?utf-8?B?KOWtq+avk+e/lCk=?=
	<pablo.sun@mediatek.com>, "simon.sun@yunjingtech.com"
	<simon.sun@yunjingtech.com>, Yow-shin Liou =?utf-8?B?KOWKieelkOeCmCk=?=
	<yow-shin.liou@mediatek.com>, Chris-qj Chen =?utf-8?B?KOmZs+Wlh+mAsik=?=
	<Chris-qj.Chen@mediatek.com>
Subject: Re: [PATCH v4 1/2] arm64: dts: mediatek: mt8395-genio-1200-evk: add
 support for TCPC port
Message-ID: <Z7vRUmETQaYRbEyZ@git-send.richtek.com>
References: <20250220143354.2532448-1-macpaul.lin@mediatek.com>
 <cb392432-e452-4460-ace6-54b3649aed52@collabora.com>
 <f09f880b7f9b642140109f17ed3f89aa44195b99.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f09f880b7f9b642140109f17ed3f89aa44195b99.camel@mediatek.com>

On Fri, Feb 21, 2025 at 11:39:09AM +0000, Macpaul Lin (林智斌) wrote:
> On Thu, 2025-02-20 at 16:58 +0100, AngeloGioacchino Del Regno wrote:
> > 
> > 
> 
> [snip]
> 
> > > +             tcpc {
> > > +                     compatible = "mediatek,mt6360-tcpc";
> > > +                     interrupts-extended = <&pio 17
> > > IRQ_TYPE_LEVEL_LOW>;
> > > +                     interrupt-names = "PD_IRQB";
> > > +
> > > +                     connector {
> > > +                             compatible = "usb-c-connector";
> > > +                             label = "USB-C";
> > > +                             data-role = "dual";
> > > +                             op-sink-microwatt = <10000000>;
> > > +                             power-role = "dual";
> > > +                             try-power-role = "sink";
> > 
> > Would be appreciated if you could also complete the node by adding
> > the pd-revision
> > property, enabling full USBC Power Delivery for the MT6360 PMIC.
> > 
> 
> Well, I have no idea about the pd-revision of MT6360.
> I could found MT6360 supports PD 3.0 according to the datasheet,
> however, I have no idea about the other fields like major and minor
> values. Dear ChiYuan, could you help to provide the value of pd-
> revision? The property has been defined in 
> Documentation/devicetree/bindings/connector/usb-connector.yaml.
> 
Hi, Macpaul:

You can specify the version information to 3.1 version 1.6.
Just add the below property into the 'connector' node.

pd-revision = /bits/ 8 <0x03 0x01 0x01 0x06>;

Regards,
ChiYuan
......

