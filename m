Return-Path: <linux-kernel+bounces-569520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C102EA6A41A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3339C7B1D1A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D585224255;
	Thu, 20 Mar 2025 10:49:58 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2118.outbound.protection.outlook.com [40.107.117.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E0E215783;
	Thu, 20 Mar 2025 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742467797; cv=fail; b=jmkeCV24EbiILvtiix4ot1AalgB+5RJEYYWWu9vn+1l6ap9XNyRuqxO3Lbw3GUza4jCM6t6fs4xLwx4mYzW4vnP4RRuSuW8sT/x/I9fN/U2XaNLKrIwfe62VWw+jhJVYvBc5O2KV05r7q5YCqOpE/1OVhxTl+pFqake1+So1WIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742467797; c=relaxed/simple;
	bh=JMt/utuLAFOOdx8BI2vnJgKv/fxtSiHlyqmvUJ6vsck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfJwfVzhh49ZFxcEJNY3IjMFGaNKI8r/Qbb+lbA8La1LG/pXHY9b3/wg2rVOvDt9cQN18dkgfEfqyKKg+DCr/bhYytgGEptKIjSLmeJXdIWGxVcQJv4kt5uMp0vJZrEEe5+Tj0lDXbNvxTCeSvAH2oOWiMCDJbvAh8mJuJAeQYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.117.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BxH272SXMd/n3oNBo6A2m2HiO5LNCg/HLXCqGVScugUbo2dPdzd5YAsP4sUQ23UtZ5QLktfFR5YALF7bm7chPLaRzTvgIjuAsN5lU0qUy75R9HO6P6ZbKP+n5ckoMru295wE1RsO12Gh4SS73RoO7MGxREfG7wht5FgWGQg1jSbzRabaeTA+0mtYy0Jqx0kVFWr4AJMFoVTbcq402nTgCwrEtPwipF7NWqjemPHYWuDlOnOCbfikn6LWydBM96vjW4Z76/ZlpygwXB4S9DBY/0rkAGYthIxYcVsG9WFxByaoWRLv6aqvupPtoqlOJI5lEMn0GJuF7547gxPKfkDDkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RV5KKqXWU06UPDOQ1FU85a/yQ6AOnXFD9MN9/pFHIt8=;
 b=TvuXditgYsza1pPmXWDhDArx5vGdr9NEjivCEk++PXMcd4diBy6AC/sbZzvxn1/l9KHGHyZbI8mk8nQKN4ucD2AEp+yWXuCjJ8lKG97fuRMCn/pjaQanA+AU9Dc7XecNE4g79nzWbkEZFSDqH7DVq8dhejD8aLNG3vhPOAv0OSauhlaslk3BixZneIWib89zpDTRt3BmaPAoxTTnbl/CtObgNzajBKO4OU+TrK/rw1YUKjdKwF8IX09c7q39f+hPo9ZARcqS5lhVgqz5RrNrOrGPLZWOmhaXaWE4lV6WTirQC38ZoleNjwvEPFX46HOtaGLGG4rzmjm9dP9fzWy/sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCP286CA0003.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:26c::10)
 by SEZPR06MB5854.apcprd06.prod.outlook.com (2603:1096:101:a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 10:49:50 +0000
Received: from OSA0EPF000000C8.apcprd02.prod.outlook.com
 (2603:1096:400:26c:cafe::4f) by TYCP286CA0003.outlook.office365.com
 (2603:1096:400:26c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.35 via Frontend Transport; Thu,
 20 Mar 2025 10:49:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C8.mail.protection.outlook.com (10.167.240.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 10:49:50 +0000
Received: from nchen-desktop (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id DF164512A743;
	Thu, 20 Mar 2025 18:49:48 +0800 (CST)
Date: Thu, 20 Mar 2025 18:49:47 +0800
From: Peter Chen <peter.chen@cixtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
	marcin@juszkiewicz.com.pl, Fugang Duan <fugang.duan@cixtech.com>
Subject: Re: [PATCH v4 6/6] MAINTAINERS: Add CIX SoC maintainer entry
Message-ID: <Z9vyy7f5NOPyzUES@nchen-desktop>
References: <20250305053823.2048217-1-peter.chen@cixtech.com>
 <20250305053823.2048217-7-peter.chen@cixtech.com>
 <7419360a-abc0-44cf-8d55-8f5fad8e9079@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7419360a-abc0-44cf-8d55-8f5fad8e9079@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C8:EE_|SEZPR06MB5854:EE_
X-MS-Office365-Filtering-Correlation-Id: d70ea60a-b719-40ec-9a26-08dd679cf074
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?beiTqLJzub/tDNNdSPza4v2i8u8YROwbx/4SCQTraQSnu/+svR198s+FNwNC?=
 =?us-ascii?Q?GTQsLimn6LRiylJejD6Jp0QENYmfdovC+EaWmXlgGKqBzBiEYp1uVtixcW1e?=
 =?us-ascii?Q?AnSvt/hfpn8dgQhUrM8a0oGgJTwemC54WfzXfsZrtqF2zvVunOCnqbKNTqH5?=
 =?us-ascii?Q?BGu1mzxkq+bOh4VgWB3tToHRS5xgzRdeboWz4Sa34OFopL8ttpgQ2p1D4E7+?=
 =?us-ascii?Q?jXEr9JV9iwocw2YuLQtO1ZPN6H4T3dOFiYLNWF0vE9KvxYA4NkoCX170Q6dH?=
 =?us-ascii?Q?rimrM1Jea4P0TpHTTCEKNEagFBCyd2B8dZiymZ+rUjwy0hQwv/IpQxvsf7jz?=
 =?us-ascii?Q?2HZAV9dI2kddgMMwiboTXMumyEtDv4GtLwMrHLs1V1votd6IXY7sllUywkCA?=
 =?us-ascii?Q?xP25NLN98pcJVu3K09v2KEEvWA++1HZ2s6bU5ByF51ECu5bR6ATxl3T2Bwvz?=
 =?us-ascii?Q?NHNWU8nq/p2+NrTLCmrg1A2aNVUodQzawpZ/0VQTYqQ/yKaoiFeBIn4rzkwR?=
 =?us-ascii?Q?QGjuRrZydFou6YivgFyQXEtn0L2Q69HpwCfzvRDthm3Eob0JI9uSnjvVewR1?=
 =?us-ascii?Q?r5THwnAFtJf4V2+hj9hWtWVbtYqhygh+zudLIVCyEQMniK80kKqtXJVvGl+s?=
 =?us-ascii?Q?narprSnHIUozS/0fcbpAo8vwfZ1gOI/7Z6NiUGmqlYw4Z9qGqxZ14lhXjh4a?=
 =?us-ascii?Q?4Y/6G7Mr/7MRWth92Vfu53r1JfCAst9lDynzIXX5Syhi3UoKIXvufq6h9HWV?=
 =?us-ascii?Q?JqjOEibk1LPYfRte6IrVINx6dLhCIBQfvDaHU2N2LqVH/NugVWXbEN4LZWWX?=
 =?us-ascii?Q?SNV6+59MZx8+/P+4s12HaEccZVlREv2keAIZUq4zrkPhPvxzz5SdVw0uysrK?=
 =?us-ascii?Q?lbwiDJy66g8pazPvPkCA9tXxTyIp7BdXSqn4zplvPrmQeNxP2/qyYaCsA6Pk?=
 =?us-ascii?Q?nBlMDcXsicOSrzylxf1QcIvi07MXzOfsA1onwoGDUTcZ2jyl0EGV/1AebURX?=
 =?us-ascii?Q?rzeDI+nt2Aonj6MjNxT5sGZK99WXZZRkGV4G9wxuUp5t2S3xbiZHsRVt4GPi?=
 =?us-ascii?Q?phFtxkG4EWMCQ5EYIW9BgDFTkGAoYG9i7/FVI9P2SyqtyRbsHV+LjtSLrOhW?=
 =?us-ascii?Q?8QycIY46w/QIWX0pa/J/jhKI6RRtYGibd4H0PdCzGz7nTiLur+cCk6nDGRV6?=
 =?us-ascii?Q?BSTjSVmFNdVh2u1s8DCuaj/P0A1kU4QpvwxY2rF/RF1AjNvhiRWmbnlg5VGI?=
 =?us-ascii?Q?D9W6YPxI/nAgpJl7qgEASOCWSZD3G72PivEnpR2MEJsRhOPYdUkxhClpHoSG?=
 =?us-ascii?Q?epV1dFHu1p8nmpCRISr50bJBvNmLxJUgCHKlS0yNCYBgOgGR56rqSmWc/HV2?=
 =?us-ascii?Q?GOEOioLqiuqND7jV5EN5KEjloBCYBKPKaZdgqHN+FxwS++sHYy9legqgkSVq?=
 =?us-ascii?Q?YnoF6M7nX0HTfmgd+mD7sSloBEP6Hp2h5EZcof8X1crwv9N9RVjip+AaW2M0?=
 =?us-ascii?Q?AhJruF4+IJ1dCsk=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 10:49:50.0084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d70ea60a-b719-40ec-9a26-08dd679cf074
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: OSA0EPF000000C8.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5854

On 25-03-20 10:25:53, Krzysztof Kozlowski wrote:
> EXTERNAL EMAIL
> 
> On 05/03/2025 06:38, Peter Chen wrote:
> > Using this entry as the maintainers information for CIX SKY series SoCs.
> >
> > Acked-by: Fugang Duan <fugang.duan@cixtech.com>
> > Signed-off-by: Peter Chen <peter.chen@cixtech.com>
> > ---
> > Changes for v4
> > - Add two dts files as maintained files
> >
> >  MAINTAINERS | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index efee40ea589f..edf26cf11ee2 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2354,6 +2354,16 @@ F:     arch/arm/boot/compressed/misc-ep93xx.h
> >  F:   arch/arm/mach-ep93xx/
> >  F:   drivers/iio/adc/ep93xx_adc.c
> >
> > +ARM/CIX SKY ARM ARCHITECTURE
> > +M:   Peter Chen <peter.chen@cixtech.com>
> > +M:   Fugang Duan <fugang.duan@cixtech.com>
> > +R:   CIX Linux Kernel Upstream Group <cix-kernel-upstream@cixtech.com>
> > +L:   linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > +S:   Maintained
> > +F:   Documentation/devicetree/bindings/arm/cix.yaml
> > +F:   arch/arm64/boot/dts/cix/sky1-orion-o6.dts
> > +F:   arch/arm64/boot/dts/cix/sky1.dtsi
> 
> Instead:
> arch/arm64/boot/dts/cix/
> 
> or if you think there will be more different architectures coming from
> cix, which you will not maintain, then useful would be a "sky" subdirectory.
> 
Hi Krzysztof,

Thanks for your comment, CIX is Arm SoC based silicon design
company, we may have different SoC style for middle end in future.
So, for that SoC series, it may not name sky.

-- 

Best regards,
Peter

