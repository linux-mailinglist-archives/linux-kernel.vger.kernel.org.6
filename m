Return-Path: <linux-kernel+bounces-298524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 312DE95C862
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45871F23FF0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376FE149C65;
	Fri, 23 Aug 2024 08:49:37 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2126.outbound.protection.partner.outlook.cn [139.219.17.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E24149C60;
	Fri, 23 Aug 2024 08:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724402976; cv=fail; b=rZMUgpkA1Kp50MZtMRcpMqSlffOnPV5GBSzl3ymu2sLeW1BihPNCznT9YoofA5//h7V4M+KIFwNkMIFZGZIr8rqXPbD563IAnkbTqVBDkS7CrUUGlbRthGaAsUyuh6IlVlKLu+ZmOcXkwxxSbZwVE0UWoZLq9uw1ezLicw5Xl0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724402976; c=relaxed/simple;
	bh=rtdC2ngfAF7cfxSPmZPCy5qLwCNeWic5//cfPwlViuY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IFyWNxixZK7lLhc+bzp9fVIuQ7T2tGDIipLl8fRHugUrZ3Gmb/9x1iZVMtjNEzyONs4C6eI7ro/9czh+/VlEci9BJWZqg+a+lvRlewTOKjceUERaJzQ6PBwzo2lP+GymjRsX36ILtRYe3c90fd40kSvh4gunHnNc0/y+1J1J6yQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckLONx85N1h5Y/MlHOAXv6zv4oo7pOTshfaq/UrVcm/cCo0dvLobkSREllqYKjUXrnGTViw5WpL2oxrm6Mgqz6QlVXGqyZ4u54mfnvH3Zbd02DeFh6vEi0y6axeRsZIQE5gkQzgYi0zgKMVOvdEAh6fglnnwlc4wyFccj+xe68ieX9oe53dzGLtuiZneanQiCYml+ajjBIoOGA9QOZNUOeDi3gb2qHCZ3OieP8zsMl8LsO6+4gcwxuTaRRD9VN//QWzFQ7+oYjZ1uRn/T4Itu5I+VRP3IRBBHiJ4uERaZcazkgCYi+P105AX3DHnkmzE5y3XxZ29X7PVqv3FOX9fSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtdC2ngfAF7cfxSPmZPCy5qLwCNeWic5//cfPwlViuY=;
 b=jUuoYotE7J8OtF+s6/vukneIhNgPBGD/+cSC+UROSktSGFSyVUZEA2EYwl6RcqtkjTgoGK2pbkzZEeXAvf9VuMpMftyXPm3ZmsXioKdIOYYlC6TCWBoOuf5IyIkLVBWx4/Wkg0dpRNwsSD4x2ey6J7yAevt1JgPC05nNX9C0hi/64VbcNM15ADzV2pV7Z/oJjElwMxqPIUKVHVO6zKmBYnHQsZiZjgD1b65qfZHI4CN5Mh93M82FWZWAEr8kn48bXmX/u5v9Vi05b8yriDz1PFmFclJICrqM3uupAneSm47CKviQxtt8kIgHi1MEM4tIfo1IZdEovtrYKF8qNIX43w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1068.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.18; Fri, 23 Aug
 2024 08:34:55 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::40dc:d70a:7a0b:3f92]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::40dc:d70a:7a0b:3f92%4])
 with mapi id 15.20.7875.019; Fri, 23 Aug 2024 08:34:55 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Hal Feng <hal.feng@starfivetech.com>, Conor Dooley <conor@kernel.org>
CC: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Subject: RE: [PATCH v6] clk: starfive: jh7110-sys: Fix lower rate of CPUfreq
 by setting PLL0 rate to 1.5GHz
Thread-Topic: [PATCH v6] clk: starfive: jh7110-sys: Fix lower rate of CPUfreq
 by setting PLL0 rate to 1.5GHz
Thread-Index: AQHatVqcyH9jOZxH00+fSahpYZMQzrIaY5yAgAK6mFCAEGCJgIAHM0cAgABKTvA=
Date: Fri, 23 Aug 2024 08:34:55 +0000
Message-ID:
 <NTZPR01MB0956ABB5D9B0D087E085EF8B9F882@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20240603020607.25122-1-xingyu.wu@starfivetech.com>
 <CAJM55Z-_sOvRnaa8BuGcupsUksaK=tuTbTmF=AtzmzkCo7y5jA@mail.gmail.com>
 <NTZPR01MB09563DBA6F76281EB06914859FB92@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <20240818-flip-excusably-c89021683d20@spud>
 <ZQ2PR01MB13073EF3BD7A64F2C098AA8FE6882@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
In-Reply-To:
 <ZQ2PR01MB13073EF3BD7A64F2C098AA8FE6882@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_|NTZPR01MB1068:EE_
x-ms-office365-filtering-correlation-id: 975d23d1-2e18-4745-2d27-08dcc34e76f9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 MW8g97MJC33ObhozgmiQLOtOwL6ijvozh0ML7dqsnhKeGN4bMaupqMhp3RYkprKrC0+COfCRN8THgOrTKLrtKUlH1yFa9ZeCkd5jlK6wF7DE2qIgGofjxVr4RsXASnkh+48ecvSJdSAFLqRg2LD526ZJJ0iq2idx+znIsegqckOTgXRJQc+LntuUMZUbXBPFPA1J8wYB8JzIZqU2NPhcThcFMCT5ORRB3Mt/9CxY1htfwlwiUujHk5RNqpUXOAmLRVHaX3no6hXPJlWpA8pLNM/q1naGFn6Bq8vL70exNYKthGuSS8+0zfS14+zMqr1vYX1sT12SfadTfIKL+WRWoSKLppfBvllg4L773UNh82N53TSQB4qmkgRe5qPkZGXyyJz0ASgMi05DKj26yGplegJsP4KA0gmti9+eweYdX9jA9R5o7HonkyT8XUUElGS3Ml2CQfIXIJa99SMqyv//6wmycV8jy1rF/809fv80Kg9hLhVqJ5WInUKYkyOVqaCcPuxANHyd4GrxYLKetrnuF+a6/uVPRPdJXPetBEhMPFBTzX2Er0soO3GbY5EqXcteuqtfFuaS1q3DDqt1tpzdmoUr5FV0htIwwXXwHq9vUfdA8h8cU7kHRSmpb0VdooQh
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dwUBZaZqB744q0YjmwQ0vCaMIPLWEbH77EO6OD5tylNC6zIKCyWRqq7sg/mE?=
 =?us-ascii?Q?xKk80J/p6Ogyau2vsnGVYIlXDRSOgN2dbXoCWTK2NO/LCv+BDB1eEACzgJtO?=
 =?us-ascii?Q?jtCHZYS4nQJMhp4LF1SNA033yPyyrcC27YvTmGqYsFshZAN3Z5lKIfGjgJH6?=
 =?us-ascii?Q?ay4n8U+7LAt/7BSWWrJlQr6Cf56dSQebxV4EkCyMRHbSZCPwtH5k/a21uEEX?=
 =?us-ascii?Q?gNNxPjD2naWxMfekIW2AkxaqRr+qQDb3g2sQlHQnjmfta4GDOBInmvBJz9I/?=
 =?us-ascii?Q?c4BC9/ezWitQWOPzTz0LumyIFsN/3Iw52el9PgfHHTPmSJxCS9Uj8hgBu1fV?=
 =?us-ascii?Q?1UeuWnIz87SKe6GbR8fUPeKy8ydvR8LlGUnt8EAZcwtSQ/Bn9hQhTrOrKezL?=
 =?us-ascii?Q?n7Ap89cVAoBfBCiU4R3zlJSV0GmMmJ5agXGC8Zrccmn3Tpa4dD0z8D9u3M2Y?=
 =?us-ascii?Q?eK7zSfhoi7ZJ3FBlEPYzbUMqI1627M7c9QIGgXVld2w3UHdHLTiECaTY33b3?=
 =?us-ascii?Q?n8enr4ZUM+14vQSdTrHGT/qDwG8EuTEYWlCoIhAchj7wzNJOnm6CZoUHyVgJ?=
 =?us-ascii?Q?6Kp9LZEwtntU9EruyiUFk5KYG4PmDJnpCQXE6dkDz5qC7hT5hULAQczpzFf7?=
 =?us-ascii?Q?JFhIVxeHukeeyhGPdt5hqY5j0ILhVynEhTbPnT9+tdPWKXP629UvcRLhMXCI?=
 =?us-ascii?Q?6gaLS6Awo8nXcgyr0a3OETN70GtH9dPtCMLfg0P2j0h+J7y2jnPfvS7Sls76?=
 =?us-ascii?Q?vwto3oAsQgAzrQGO5/vq7osKfqGn8kTYOPETbZ5HUsK2hgFhm8Okt7pnBjru?=
 =?us-ascii?Q?qKfRTopnoQ6QWnXO3oI3Y70E33TZC1ZrozLdPEISJTmUBaly0s7gtmqVWwb6?=
 =?us-ascii?Q?6hxWW5uvmhAFrHaDqnqJXC9pilozPQ3HhrcSJnGOIFeUNhq4+QvK0odmTf0a?=
 =?us-ascii?Q?k8SCzHPbdST5onKq7QYb2VG6nckuv6tCslkrbr8apyJMcTQ4/WY3hbsrYYdH?=
 =?us-ascii?Q?W72aieI8HvOiApuy1uSH6XWA4gWiKA2rmhQjAJA8DbTG9fXxSuMXd8IjLevF?=
 =?us-ascii?Q?DkIUe8Y0NZPDq2AEG2b7dpzqzIjYCW7qYt5x30px5ULDYmQXDGz1FFy6gwWK?=
 =?us-ascii?Q?uqjW9ELhM8GMquaghBr8zHCfxv4II7asMR/O/nM9e7kU0gWr7IAiPDH6JnWg?=
 =?us-ascii?Q?SDnNducmc4p7Oh1zTmld9h664VLn6okPhjTD0bUSadnoFxoTXX6xfSWgBW2z?=
 =?us-ascii?Q?h1TMyBIaz9H41KldAg9fSyiebD/YzKOmJaRMdUsj2lngC7aZw+A43Lqf+xXf?=
 =?us-ascii?Q?fhYGHPEnHPsVxTItTalGDeZ/7B4cL91iZSGXM6Q/S8A7ZGDEd6rLoi6qiBHr?=
 =?us-ascii?Q?pDlON1jID4Mwo+uf0cYWp80Lnl2iibK4PMlfqoMG1kOOgygdIlDTn4ADvwhj?=
 =?us-ascii?Q?Ng8+3rDI6kQQOY+oC6hI55Gv4/3WrlvYSRKRes7XfZVWx7M9X9R5SU3qhRn6?=
 =?us-ascii?Q?w5JvHqJhtu8gx55VahTPVhMFeXECh3NNNl2jPKGIXjhRSzts87F/uZp97Mod?=
 =?us-ascii?Q?zAO+nxMzFZoCP4XrP1rgAFbwff8hjtMaoCfK/bKE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 975d23d1-2e18-4745-2d27-08dcc34e76f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 08:34:55.0491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IcbxLD8ORtSPhNuBcI08ESYxBvFoSMThor+F4mPD9ttAejzyBFsfPnpOX78rT1ilpotcLk4lqsn/0iy/0CwTxMwdgm/W6FNrk3Pg4t4LOfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1068

On 23.08.24 11:42, Hal Feng wrote:
> > > >
> > > > I'm still not a fan of hardcoding cpu frequencies in the driver.
> > > > You've added the notifiers exactly so that we can use the standard
> > > > device
> > tree settings for this.
> > > >
> > > > In other words I much prefer v5 of this patchset.
> > > >
> > > > /Emil
> > > >
> > >
> > > Thanks, Emil.
> > >
> > > Hi Conor, what do you think about this issue?
> >
> > Apologies for the delay replying, I didn't realise there was a
> > question here directed at me. My only real thought on the patchset is
> > that what is done should not cause problems when the same devicetree
> > is used for both U-Boot and for the kernel. As long as that's
> > satisfied, I don't mind how you choose to implement it.
>=20
> Actually VF2 U-Boot can run at 1.5GHz. It will work if the PMIC sets the =
CPU
> power supply voltage to 1.04V. The reason why we run VF2 U-Boot at 1.0GHz=
 is
> that the default voltage supplied by the PMIC is 0.9V which only supports=
 JH7110
> cores running at 1.0GHz.
>=20
> So v5 of this patchset won't cause problems if the VF2 U-Boot makes some
> changes to support running at 1.5GHz. And I will make these changes when =
I
> implement OF_UPSTREAM for VF2 U-Boot.
>=20
> BTW, if v5 is applied, the patch 2 of v5 should be rebased on the new mai=
nline
> since jh7110-common.dtsi has been created.
>=20

Good news. Thanks Hal.

Hi Conor,=20

According to Hal, U-Boot can also run 1.5G so that the dts from kernel can =
be used on the U-Boot and could not cause any problems. So the way of Patch=
 v5[1] works which Emil agreed.
[1]: https://lore.kernel.org/all/20240507065319.274976-1-xingyu.wu@starfive=
tech.com/

If you agree, I will submit a new patchset soon and modify it for the new j=
h7110-common.dtsi.

Best regards,
Xingyu Wu

