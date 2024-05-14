Return-Path: <linux-kernel+bounces-178495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E32E8C4E84
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 11:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3BAE1F22A96
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 09:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9363D551;
	Tue, 14 May 2024 09:13:35 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2090.outbound.protection.partner.outlook.cn [139.219.146.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC85323763;
	Tue, 14 May 2024 09:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715678015; cv=fail; b=hBwwOjGztGZEp4FbF7DJP7XxLks+Ey24fFQLIteoilivXBjhUV72VfwS4ofHdQT89OuOup7PEFWHJgsC9j8eHXDvkanR4WiY8iaWfxc23o/hucxT6En775gotSx0bZwCNOSMcpVUctJjQ+stLbKQRDUY2ycNZ+Fcav+bcd0Wgj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715678015; c=relaxed/simple;
	bh=XcIdD0Ev4gpHLC2xbiBnygH6iDqeWbRLm6uGgpswxeY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OAqba886gf83cyHImnztPq5WP4tNWh//LdE/V4fSwoYFmVM7Fomq705LGE4ScKR0L2ogt8rqjHtsQAnnQvIVCKXhEx8IaR4jM4TGta4HD94a7nFGqyydrY7a1TGeHKnS7e/p8kl1zhxPumdltO2Md2KkK+jasqKjMyJAUnvWypc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLK12ondh2aaBPXPJHEIuYF4aMPOJ/o1/pndXQ3Qqu+aq/ggm51gHScUlw2QuQGJawumplE59K1AbDXQazVo2nSQfNjjEmW6u4E5RlKJQJuknXEzOB/99okWaFkzxIRCGQv32hG5VvO7OpoFq4NEI7L7i/zAFAeZQHZlw3MZ4xC9wHhO9xb+q44HQEs/l6YzKi5XAQ5UmlPVwA7FeFvHrQgIetP99PrV1fAPd4c0hVvB7rTnVPQ3Hoze/kaD7uVuAyOzYs2orpyPzcwECQNpVemp1iqoIRnG69bhQmeSXSCXXVAGGXLGfGhaMR+7t+NUH+5F7+sExI8AiNUKwUDXOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcIdD0Ev4gpHLC2xbiBnygH6iDqeWbRLm6uGgpswxeY=;
 b=hTQ84przq7UMrOBTASEiQjsQmW1lHDno/QBdhVPMnhoyLhOT5mLQ3n8lUTTYF+Fuxno81Jg5HYnVZ0JAGI767c21+mt11lwLxHkiuw/mzq9oowG5G5o2QmZ0HmAhd5A+NvexoDdObRO/u4N15Y+ZvXg3AJhft0MfAmWP/xVYnUN7mkRvXUw9wrwKRTmFiOUizH2/JpwptY1UV6EJtLGePzgU3sHcV+exPurEJYMjBVHTshkikNsPZAIGzW9jzckHiS6KroMJV0L5wVXTXZNJsLo6tCNgIWpQri0lfOzlJq64n1PePuktNlFdwZdRbD0bfVRXSSnEZYktRv78FFgTFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1003.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33; Tue, 14 May
 2024 07:40:03 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::e903:99a6:10b7:304d]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::e903:99a6:10b7:304d%6])
 with mapi id 15.20.7472.044; Tue, 14 May 2024 07:40:03 +0000
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
Thread-Index: AQHaoEtCPDK2HwhwXUSWjcDZE/pIQ7GQ+umAgABXAkCAAKg2gIAEWZ+w
Date: Tue, 14 May 2024 07:40:02 +0000
Message-ID:
 <NTZPR01MB0956A7393097129D3CD048EB9FE32@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20240507065319.274976-1-xingyu.wu@starfivetech.com>
 <20240510-unfounded-syrup-d1263d57d05a@spud>
 <NTZPR01MB0956D48361098E8AA4B3930A9FE02@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <20240511-unbiased-dainty-ccb5ece9b1b9@spud>
In-Reply-To: <20240511-unbiased-dainty-ccb5ece9b1b9@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_|NTZPR01MB1003:EE_
x-ms-office365-filtering-correlation-id: 9fea678b-8ae3-4c0c-381c-08dc73e910fd
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 BQOgBIxEWID32f5nQZsBJr6MWbtq+iKQpJr96dA00ETrp5mHkoNZSJE2EAXV+ImZD+ZrT/rbVTE/zi4c8fH8ksQN1PrNH47SJhcj7UW0k2vwoNV8Hv9F2Z7QQ+Y8KCcFFFxatjtmLem7vKDc+n9JRYP5hRO0OCs+BnIjaCZQXvn1wG279VCBXd+ML43AgDaL5cCcoRlL0B6vf/3IWN3X5mIsSsq0TtHeEzSrijvHwI7+JUjEx5K7DQTdp2gAntikWuJUOGi/tpzC0r9OWFtZu6MvxSsV0WXH9dIrPbY6KSVNo8S21A3UwiZtb4UvNVmAelXvUMuFhlQIYg5DtBsYVDO7OJc+JVionZwZ4Ig4yosSs/pPx5d8ux8JyXJdWtjnM9AaqH5oRVNSIUEjWoY+/cI/57nCtpRJrXEIQoP9QsOP/tQaFO7H349RYm3di6Tcb9PPLoB0+1G1Pw6lauAh7IK58lrp7+zCiUoKLjCKSqgBsZaUk4w0RbFe4x9jmZ9L+V7NV2NEqnb759mxMpDYMLAERlyEK6LolnZUjQwSmhjCaKBlTJ7fMsl/mZfvSUb9Gy2t1jiHPvLbxAO9pwL/31FG0BSANfnSwCeUhFqtIE3fLu+yAZF87h8gX6DWI2E/
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(41320700004)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xEKKK8uwB3urTPd/RPalwR9qWmSmbZnBl/D+/qhk/eBjco5/l3xlQ0kWwBTW?=
 =?us-ascii?Q?Xxhw9bmiKajoaP7ZrL4UYQemhUmOjby9RI1LfZmNt4CVK16FnnsUpSgeU+un?=
 =?us-ascii?Q?vqcvsAlyU7mlORsOGxs8SxJAmW0fPtPGyOuVlvJKucZXRIUre1Wz6+qpoisN?=
 =?us-ascii?Q?R9hBfvo/rBt6QjmiWbGtrOGmI1uw1rDU6I6GxrNhnp5cqBQc70YgczbkFRdU?=
 =?us-ascii?Q?vktPpGhYkIOgvCq4j1bqDjAxK0tOn8rKwLrfltJg35LtpC9MFWjaGkqbLCDe?=
 =?us-ascii?Q?uPD3izB29TDWi5acckMRdp4KJsYo/0dmf8uU9trhSQcBFPL2vXYzMnSh0KzE?=
 =?us-ascii?Q?sC9TXDunAsaqp5Wfds0q3Gqz/sHMnO+tXOw/40c5DL5FPGyZkQCgd84OW5ZZ?=
 =?us-ascii?Q?nh0Yqzt6LmgGdi0y9AgiQvvD39WdQvn7lJqaiXTgazfQTgofx0xwuyhRtA/s?=
 =?us-ascii?Q?JL92x3zrCn4Ocx4mfWt9KIOudsAleEnI0ORPn7w6FKCy+U0pkJpW1nFMtGje?=
 =?us-ascii?Q?EQ/1mkQ7vGKzjHXOMpQcjhERVb4OOgUNd9l2vYS5SnSoCVsMfnYCFokx+ulO?=
 =?us-ascii?Q?OLJSyQlUYFdB1kWcaiCRBYrRT8xhv5w32q3+T4EduWavd4jo5k7b/0cdSbO4?=
 =?us-ascii?Q?GVWs7BlUdweMi7CyTD3TvFyZo2yh7Nv4/I3PQ4zQ9HO8L8Znh81i+aiKWoRP?=
 =?us-ascii?Q?CfClOqevJpN/vK7y4jzJaKG9D738DpKMt29Q0SkJRLOe1MXkzk94NcotB+bX?=
 =?us-ascii?Q?fZn6PcHJSf6Tq5DhpZecA6WCtsQLWdIGrmBQKRxpmKyWx5jQ6tSFsx7SKaOr?=
 =?us-ascii?Q?m0fnZpyM19MWZq10640VWFI7OnlGDoPrlxrQnSDQwmYjCcK5vL8R30Hg561L?=
 =?us-ascii?Q?Ey3u61ZF7SWh/Wove4AN/EeRAmR6g6mMF0VkKVFC+ytUdKGxcqAyS2yd3Grd?=
 =?us-ascii?Q?FQaeHiJziYFkfVSqZcqqibVmcm0x3g2RacCBnXO8ckzgOW80uGMF9VskXPHx?=
 =?us-ascii?Q?04ZmgiWo9FxHhebmiuWkBWXzSdzYAXGxxjlJvCLTZlYHKuY3Se3MHM/Uf36r?=
 =?us-ascii?Q?26eYy76U/BjPkPLmxS3+IDzP21YDj9tLTmbeejN5rfshqeazk4a/0hW58F9G?=
 =?us-ascii?Q?107yl4lTFta455t/SS+gGCdIp38lM3AJdtbPomiIMBG0RSF0DiC874qJHLFu?=
 =?us-ascii?Q?CffRWc9jNU/jOypgoDjayrRBjAPStvXSweZn/610tLQozZpJwXd/iu/boMYI?=
 =?us-ascii?Q?P8dIQzEz52TrtnpGStlPjiGbZ6E/SNOCzQ6mMg+IkVfPY55KErIqmOjRMW+W?=
 =?us-ascii?Q?lYAa2Ju1+0ayFGjzZMZFJuFzNJsrOHPIFaD6CnR6+aBFDJI+voNI8jSIzLJw?=
 =?us-ascii?Q?2gQ0nBdDBtapKVfSQ8hXauGTjNbOq0O2rVkbApwnFWENorUo+ykPdedP448d?=
 =?us-ascii?Q?hTHpqvysWuoSu8AhRhThm9amF14n5jxJUu520RYQfLgbKScp/7gM/wvJwIth?=
 =?us-ascii?Q?u1RkUygdoYpblnni5C6cMHRsqGQEe6GZYuN196TgyRIHLsLbCx7Zzheuhiu0?=
 =?us-ascii?Q?pu+YJ9mq6BaHLYP2fJ9kNpupKvmC6c8WsBjjQSLJ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fea678b-8ae3-4c0c-381c-08dc73e910fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 07:40:02.9101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U5U++6IwC9bjV3E6eM5/q53Oz1PUPDKmNPB6rOiLQ1HG24X8D9Vsc3cMKbL8zfzqa4Y1nZzOLuipFaRJBk0DkAgJvkIZpCNHiFixEmMGWLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1003

On 11/05/2024 20:19, Conor Dooley wrote:
>=20
> On Sat, May 11, 2024 at 03:02:56AM +0000, Xingyu Wu wrote:
> > On 11/05/2024 05:05, Conor Dooley wrote:
> > >
> > > On Tue, May 07, 2024 at 02:53:17PM +0800, Xingyu Wu wrote:
> > > > This patch is to add the notifier for PLL0 clock and set the PLL0
> > > > rate to 1.5GHz to fix the lower rate of CPUfreq on the JH7110 SoC.
> > > >
> > > > The first patch is to add the notifier for PLL0 clock. Setting the
> > > > PLL0 rate need the son clock (cpu_root) to switch its parent clock
> > > > to OSC clock and switch it back after setting PLL0 rate. It need
> > > > to use the cpu_root clock from SYSCRG and register the notifier in
> > > > the SYSCRG driver.
> > > >
> > > > The second patch is to set cpu_core rate to 500MHz and PLL0 rate
> > > > to 1.5GHz to fix the problem about the lower rate of CPUfreq on
> > > > the visionfive board. The cpu_core clock rate is set to 500MHz
> > > > first to ensure that the cpu frequency will not suddenly become
> > > > high and the cpu voltage is not enough to cause a crash when the PL=
L0 is set
> to 1.5GHz.
> > > > The cpu voltage and frequency are then adjusted together by CPUfreq=
.
> > >
> > > Hmm, how does sequencing work here? If we split the patches between
> > > trees it sounds like without the dts patch, the clock tree would (or
> > > could) crash, or mainline if the clock changes there before the dts
> > > ones do. Am I misunderstanding that?
> >
> > Oh, I think you misunderstood it. Patch 1 (clock driver patch) does
> > not cause the clock tree crash without the patch 2 (dts patch), and it
> > just provides the correct flow of how to change the PLL0 rate. The
> > patch 2 is to set the clock rate of cpu_core and PLL0 rate, which
> > causes the crash without patch 1. Setting cpu_core rate is to avoid cra=
shes by
> insufficient cpu voltage when setting PLL0 rate.
>=20
> So is the problem in the other direction then? My dts tree will crash if =
I apply the
> dts change without the clock patch?

Sorry, I tested it and it could not crash using only dts patch. It can sepa=
rate the
patches and use it individually.

> Additionally, what about U-Boot? Will it have problems if the dts is impo=
rted
> there without changes to its clock driver?
>=20

It is not apply to U-Boot. In the U-Boot, the PLL0 rate should be 1GHz to f=
or GMAC
and PMIC to work. But now the PLL0 rate should be 1.5GHz in the Linux.

Best regards,
Xingyu Wu

