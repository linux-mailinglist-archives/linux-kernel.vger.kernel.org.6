Return-Path: <linux-kernel+bounces-179347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8332A8C5F17
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE21BB21B6D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 02:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF2FF9E9;
	Wed, 15 May 2024 02:24:03 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2137.outbound.protection.partner.outlook.cn [139.219.146.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A8263B9;
	Wed, 15 May 2024 02:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715739842; cv=fail; b=bOlePS6yh7cZGNCHGbuyEAnfd5iqsE2wFfZbZye8/q1oX+lfbl0BlDiPCyazt0BNGHIm85AG00uCtG42S0B6as2iOUYheCqwYl/xqE8y2F/iSONhe4tp/L4hPP6NreaoolchX0yXx9VYTFEUyAQ4Ftd80qSYUjBifxWIXPqU/ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715739842; c=relaxed/simple;
	bh=5IYkLseJvz19J9hXRlZ3rNQvRG/Jg2vmGfRjkJjt7Y0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QdtGnOvdFOmcxHxJlgVGkPdYa76AdC8hhiA5EF9mnCAf9n3cxr565hauYwG38ItpMCt1FKtM1KorgXe8w8yUBbhFndxr9hY9LB1zNoc6YK8S6TH0gQHGAMCY+WNjZlRHxdPtjV2XA8s6wskXcQPZnEJJMDr+FyrDVR7FDkykdM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfKegW3oePo1ggSmdca9j9PgtC8D0J9/IlW28+Pc0HQxBFX9889GnusFD0oO4K6ujjJsGPPs411ndrUig3XcJlwrrRcRirLzVL+2wCP0lLI14GtH1b5yOyx4lULdKg6ykyqporKmfFWo436PG/85GJao90eyNvkd9g2c6i/zfX9CZBfz2PwI6blE3ChRK4Ux3TskpkQSbryly7/O6mYnGBhzSS4RNdLAPMh9gE+uChb2GReK+NtfYM1jrsquVeKJLMd+aruYP8K7vXTCbK8OE+Q4Gboq6D3XWpsdi1EvKRcnSlZ8upkG+0Fagf2EfY8nRf3JIKf2y82Ug0sJFy938g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=juykI4KxJpPd+HSTYr18AIlTmvsWU2/XL7PboPIe8Dc=;
 b=Klpvrv6gnzNOttslvI6XXqUcb4sDco0FediEMdtm6nSwy4c38Cvyk7CvUyo5qDBnHSipJrHWeK/6OzkrP4OnnRXhfpgVH9LHjf/ww5kfRTdF+NLXM0cvBmUE6ts1BPraXpNOO1wutDVT5Ydaz0lkWATZOvPkLJ4SZe3v/quDuKx2loNgbAOTE9HOYUo8sF4ijGt8TSntEsNTSdv+hGHZBh/5TG3h+k5aXWNaI8BeyEd7qCHfq6NGBy/Hbp616tclfdVfUhRmh9mAFXYVaoGy/ucikcGivWh49hPQ/vfbvhKriRB/0088P13++Viv+Ak+tbJdgr+u34pt/0mE2ALwAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1002.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33; Wed, 15 May
 2024 02:23:47 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::e903:99a6:10b7:304d]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::e903:99a6:10b7:304d%6])
 with mapi id 15.20.7472.044; Wed, 15 May 2024 02:23:47 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Conor Dooley <conor@kernel.org>
CC: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Hal Feng <hal.feng@starfivetech.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v5 0/2] Add notifier for PLL0 clock and set it 1.5GHz on
Thread-Topic: [PATCH v5 0/2] Add notifier for PLL0 clock and set it 1.5GHz on
Thread-Index:
 AQHaoEtCPDK2HwhwXUSWjcDZE/pIQ7GQ+umAgABXAkCAAKg2gIAEWZ+wgAC+9gCAAIQbsA==
Date: Wed, 15 May 2024 02:23:47 +0000
Message-ID:
 <NTZPR01MB0956CF1AA9EA5A20A174FD8A9FEC2@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20240507065319.274976-1-xingyu.wu@starfivetech.com>
 <20240510-unfounded-syrup-d1263d57d05a@spud>
 <NTZPR01MB0956D48361098E8AA4B3930A9FE02@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <20240511-unbiased-dainty-ccb5ece9b1b9@spud>
 <NTZPR01MB0956A7393097129D3CD048EB9FE32@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <20240514-congenial-smother-1e4b0fc6a5df@spud>
In-Reply-To: <20240514-congenial-smother-1e4b0fc6a5df@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_|NTZPR01MB1002:EE_
x-ms-office365-filtering-correlation-id: b2c51c7d-98e3-42a1-5224-08dc74860d1b
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 dM12cF7KI3pKWC0YB1+wvHJVT1dtjIqhwI8p9w+sssXLO1QPYFz0ue/GEKcWUhNzTjRZ+nzFXr9lCp/DtXj7nCBgctC7yAtRxVOvlhBFFkzd27XB3EHQ3SazLHhPw1MTMkPpb4MQt5M8bee6zZEvqNe1tpZofXbxm2QDjhYbykAIBndLwShmAH2n4NnfJK35pYCgTLv4djP32LJpnNYVdsAQImMGVClEz1spJASJGOrbB5UvdWN7a8/vKnbpY4bo4pgwrpeFbGTE9hrTBsdb2/JWGf9Bu5eqAfMQ+EhmRWkUEiXLxXXhaXhk7jHguTFs+YOCJSOxoep5e780aHhX5G4EcXTREBEwjUuPYKSNOVy7f/q5JJrd9OnfZnKPdnXHM3hMpB/ROKFTPolNjNUaOJo5mTB7r/ta15InNsVba1vliOEiG5vQ/lsP2cDjYMzFHhTB/LtC/wxxQLO5ibtvrQcFmUAswHy4PYtVkflW5t+q//zUlNqLA7KHd3/TIPdxC46d+9sfur0kA9/O+44EtmjTnipLkTwNANkWGWP4cnvvrLTzaUZLNYSLaKNSfCMx7N/QkXq05LN7KaMWu71UlFZBTOovjujQY2a5tXZ9YNv0r3mkc/Js84O8xxEEPaXP
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(41320700004)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ogPuLDcKEquOYoRpp1omm5qe+K4XtmbiH6L85hZqMSUDkFLJ0gdHGARkh0ST?=
 =?us-ascii?Q?+feJwKMDpEkkUHqeugg76x7wdND8hrWRcCGcYA1e9fUNBRGe4XOKkCK/1YmL?=
 =?us-ascii?Q?x/ijGgb8vVu0+lM6XJkcad0DoWzY2+4mPe0CzEZvtVEQ67yzJaNiIRXfz4ly?=
 =?us-ascii?Q?1Ab9LUXcA2PQ6CLVuXNLPF7jakrihDjccpRdXLPsiTdh8xKQE8yD/lJNzn9f?=
 =?us-ascii?Q?kiS3ACI5l32yD3m2fvJp+2thrghFXeC4LcOUEagFbxnWV5Irkoal99UJbIqz?=
 =?us-ascii?Q?CZOfnQ4PzY32DxKZFLwrw5H/gUAdt9/s/VzvL+yV+x5Z9Qr+vWuryZ4FoxFY?=
 =?us-ascii?Q?0FnvGe7ZlnrZZ63tjc43YSYVGtgy/91zt4gGPhc9tSDHqpHGLUhTmkVJPI4G?=
 =?us-ascii?Q?5TQLjMlGndFCoUpew87pPoYqxgp63Xoa7rCResBSXYENV9PawMbdaYvD3Uji?=
 =?us-ascii?Q?wZlEQs3cPTlOtPWEVNBTTBX5sxuAJ4mW3bzWxy6Lib+ENfCwIyWf7hg+Ti0y?=
 =?us-ascii?Q?FHL30p9J49cTXlQnGOVsuC7bE1KlJTkv2PTWXWCHdr/Fmp9qQJMfAAU9L7Ek?=
 =?us-ascii?Q?x1ZnWX7ROxWlfnNNT8o0GJzXNdvqEe65xXoZ5ywbw29NYIWE/nVoK36pMk/f?=
 =?us-ascii?Q?znPzyYK5bNOnGMVRfoyPOFqqxM9GtY7ChJaHk9nmrxnqW46yM6EBu4ObqkC/?=
 =?us-ascii?Q?HBfx8u5w2gWPY1hH3iIjZVWAjA5QLGZjSF8jf6edRQusZ7N+f/QwtynzIxZK?=
 =?us-ascii?Q?aIVSc8H6dlrJcKLFOHQx2avVqR3wRHOsIU5IeVlLVDUwIv+tFs293FuSwTyY?=
 =?us-ascii?Q?kZ7yMbZR2ibKn5WzV4GdLXId1KyKDZumIg+Ld4C55RPM/6p05ToMoxzNNQbe?=
 =?us-ascii?Q?7KIkDoY5R3f8nYOuD4G5RVD3kx+Dxc5cATUXxO2MM/CNNh8wiPaLtg3sqpKF?=
 =?us-ascii?Q?wngALbbTjRCCS+pcxyyI/C4mXiljZlqEcnf/4UqmX9Ib3WfJZrMhRN038in9?=
 =?us-ascii?Q?y1l12xTTlwKMUwPS0i4sIuFftvPFEwu5PalGv5zbx8U/fWF30rSzROoxqW0M?=
 =?us-ascii?Q?OG8W5GwferafH/E082mTfzVpWgUlb1hhxQdhOcXW/lCHlLmuciQVbFf43rhm?=
 =?us-ascii?Q?SAGR97eY7C95Ol0+mdrACQqUC67cJOw0jOJCsO2olUKBXSNVnPMuaV9ABocO?=
 =?us-ascii?Q?B02tccPmLXuDoFQiGjkAsGkAYLjp8Tjsqvlndxbl25MVrnNiDMYtHkCJoKyu?=
 =?us-ascii?Q?ZMAz4VOJAgaxn+2HPpzTgh2yGhkdxP3uIyCpAGlJSRr+a0BCtFwyc+GLI6Dc?=
 =?us-ascii?Q?7VndP0awnGvWBNumJmFWXddsH7SBTo7NfeorBtpn9kjgL2jG/BiGT6qPvdMP?=
 =?us-ascii?Q?Fucxq8PAXQRIAebn4tTJIFyU1FEhGmKfVCGtJXHPKxB57mqnVCG/SXTtiE6R?=
 =?us-ascii?Q?JCG3/ZVyewAwIrPFTZPY2WCdRzoLjI2j04TSeLTJJs+F/y+Mc+7qbXke2wy1?=
 =?us-ascii?Q?jxINluR2obToPE7pF+adke19xV2RGtqMxG3MSzE+8miTidHg11vWFQdUHyli?=
 =?us-ascii?Q?SWBbAK6lsKW5NAKT4etjirM08Fe0UHcBchjufahJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c51c7d-98e3-42a1-5224-08dc74860d1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 02:23:47.3879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UyVjhXhus+Kgyj53BnzJgu+11+S/IUuc97Ckp0rmMp4tUZi3nUbfpO4l4EK006b3/6VlhON6hMZYMdjq0FINQ7ki7DsfLmyvMbrMXAdrLdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1002

On 15/05/2024 02:08, Conor Dooley wrote:
>=20
> On Tue, May 14, 2024 at 07:40:02AM +0000, Xingyu Wu wrote:
> > On 11/05/2024 20:19, Conor Dooley wrote:
> > >
> > > On Sat, May 11, 2024 at 03:02:56AM +0000, Xingyu Wu wrote:
> > > > On 11/05/2024 05:05, Conor Dooley wrote:
> > > > >
> > > > > On Tue, May 07, 2024 at 02:53:17PM +0800, Xingyu Wu wrote:
> > > > > > This patch is to add the notifier for PLL0 clock and set the
> > > > > > PLL0 rate to 1.5GHz to fix the lower rate of CPUfreq on the JH7=
110 SoC.
> > > > > >
> > > > > > The first patch is to add the notifier for PLL0 clock. Setting
> > > > > > the
> > > > > > PLL0 rate need the son clock (cpu_root) to switch its parent
> > > > > > clock to OSC clock and switch it back after setting PLL0 rate.
> > > > > > It need to use the cpu_root clock from SYSCRG and register the
> > > > > > notifier in the SYSCRG driver.
> > > > > >
> > > > > > The second patch is to set cpu_core rate to 500MHz and PLL0
> > > > > > rate to 1.5GHz to fix the problem about the lower rate of
> > > > > > CPUfreq on the visionfive board. The cpu_core clock rate is
> > > > > > set to 500MHz first to ensure that the cpu frequency will not
> > > > > > suddenly become high and the cpu voltage is not enough to
> > > > > > cause a crash when the PLL0 is set
> > > to 1.5GHz.
> > > > > > The cpu voltage and frequency are then adjusted together by CPU=
freq.
> > > > >
> > > > > Hmm, how does sequencing work here? If we split the patches
> > > > > between trees it sounds like without the dts patch, the clock
> > > > > tree would (or
> > > > > could) crash, or mainline if the clock changes there before the
> > > > > dts ones do. Am I misunderstanding that?
> > > >
> > > > Oh, I think you misunderstood it. Patch 1 (clock driver patch)
> > > > does not cause the clock tree crash without the patch 2 (dts
> > > > patch), and it just provides the correct flow of how to change the
> > > > PLL0 rate. The patch 2 is to set the clock rate of cpu_core and
> > > > PLL0 rate, which causes the crash without patch 1. Setting
> > > > cpu_core rate is to avoid crashes by
> > > insufficient cpu voltage when setting PLL0 rate.
> > >
> > > So is the problem in the other direction then? My dts tree will
> > > crash if I apply the dts change without the clock patch?
> >
> > Sorry, I tested it and it could not crash using only dts patch. It can
> > separate the patches and use it individually.
> >
> > > Additionally, what about U-Boot? Will it have problems if the dts is
> > > imported there without changes to its clock driver?
> > >
> >
> > It is not apply to U-Boot. In the U-Boot, the PLL0 rate should be 1GHz
> > to for GMAC and PMIC to work. But now the PLL0 rate should be 1.5GHz in=
 the
> Linux.
>=20
> There's a push in U-Boot to move devicestrees to use "OF_UPSTREAM", which
> means importing devicetrees directly from Linux and using them in U-Boot.=
 I
> don't really want to merge a patch that would present U-Boot with a probl=
em if
> the VisionFive 2 moved to that model there.
>=20
> Cheers,
> Conor.

Would it be better  if I  change the rates of PLL0 and CPU core in the driv=
er not dts,
and avoid the dts of Linux and U-Boot being different?

Thanks,
Xingyu Wu=20

