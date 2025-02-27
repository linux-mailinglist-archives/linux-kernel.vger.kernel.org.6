Return-Path: <linux-kernel+bounces-535793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A74A4773C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FFCC3B3BC1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6006F228C98;
	Thu, 27 Feb 2025 08:02:44 +0000 (UTC)
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021136.outbound.protection.outlook.com [52.101.129.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94476224B0C;
	Thu, 27 Feb 2025 08:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740643363; cv=fail; b=FoXvLYtsynr8PFdfDEYlcLgVOx9nkeftJ91wqtsRUA6gTAsY0+lGaQEcRko1RewaJID+tTluLhNjgW83Vn1UkJE4vZm8BsfyKtpb/Ge6fJ6A1OETS7yeDw39AmmGyUf7KgZIf3UhL5bCV5Urvr25UAWlOyXizDGPZ4Oa4CyL5+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740643363; c=relaxed/simple;
	bh=bcV5UQKUDHLhpDdNhASwxNaXhFW2KhMHuw4U3smrGPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=doPgVLkRA3PbM3Qbxj6Py+L1BFBDiKGlDJuGIHD99LrMn8L2PjS0186CF9Y/9SUfRKk8yUqSt/O4sX86XHJRRFJvBSflmnEwxlIWRHI4fv5LMnK25HSaaWACWv0hcw8JzT399BGkbWhogTmmpeRGzEkOiCmAOEIRPti2ZNrbYNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.129.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3Ho67NT1GGHYegZR53ey/yX0FU6wuOhlnptfN7e6uEYb2xmHGx/7Mxiop4URttsjFYnR7id2mnBMcUkVWjDsyVIbek8pKzPyBDe/wW8f4sv7uVbyNwRE3AAg9Pg/qMWnm0IDmHrooPYoPT2gmk4rVirif7viTsUiaw54vk/t/Od9a/v7Lmj3G/UmtbiktfabtNGq1++VS85WwnhF0zV4LAWHnW+OP9W4lFrLesfETsZ2RfSPtntpGPV/OXuyTFE/m+9csz3t6/ws7dcwrDCwWVvB2gnmGI6SsEWO03LK8nzQVT2AmWW4nfmq1Sz+uEHibEAtFPk6AxFvq3xWzGFQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7G8oAH/Ew6gLeT9TcrpZ2QKWMwxr9IDnpJF8qnubCAc=;
 b=py6XJVbPUSi0DIqFi6ihw3j10QRxSKiVnAskXVFx1g+h9oRMHOj6kuqk0LtChV4JLY5C2Q96LGNN+4HjYMLgpf1hIrCZkbFRn84b8Ii7sz9SRlaiK4aei8kgw2nufQ2bcQfYDjDkA6fIscW5xt9oLrlpH1A9tCl0oe2toCUcnhm3VNI+nCn7TXcU7H54rN76VgFgrmKr9EJYDYjapUYSQoYQKG7ZweAz6UMoYnrgC6pMdmWlRsrC2cUC0V3mWIJVU5qHq/l97K4zP3a2H3hvFjcMCuxoMlA6n2DBqijZF2bhGDF6snXGjjaUJUhv6+qV09Z+LbeY6+71dkazUJln/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR01CA0072.apcprd01.prod.exchangelabs.com
 (2603:1096:300:57::36) by KL1PR0601MB5726.apcprd06.prod.outlook.com
 (2603:1096:820:bc::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 08:02:37 +0000
Received: from HK2PEPF00006FAE.apcprd02.prod.outlook.com
 (2603:1096:300:57:cafe::99) by PS2PR01CA0072.outlook.office365.com
 (2603:1096:300:57::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.21 via Frontend Transport; Thu,
 27 Feb 2025 08:02:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 HK2PEPF00006FAE.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 08:02:36 +0000
Received: from nchen-desktop (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id B602A41604E4;
	Thu, 27 Feb 2025 16:02:35 +0800 (CST)
Date: Thu, 27 Feb 2025 16:02:30 +0800
From: Peter Chen <peter.chen@cixtech.com>
To: Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: arnd@arndb.de, catalin.marinas@arm.com, cix-kernel-upstream@cixtech.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org, krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	marcin@juszkiewicz.com.pl, robh@kernel.org, will@kernel.org
Subject: Re: [PATCH v2 0/6] arm64: Introduce CIX P1 (SKY1) SoC
Message-ID: <Z8AcFq9bDuW0oiD5@nchen-desktop>
References: <20250226012136.854614-1-peter.chen@cixtech.com>
 <20250227045236.2830419-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227045236.2830419-1-liujianfeng1994@gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FAE:EE_|KL1PR0601MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: 86aff9b7-7882-4f7d-c66a-08dd5705197e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3WRHRP5kyJdhSG1LfbekWqssubqtz/2zKmel4f11ZmXSVfazHXvMOcbOe6+2?=
 =?us-ascii?Q?IqZvNjryLKw2/S5AbR6vNmzE3O9UPy4TQGhh5cGLc6dnHkoiMTXVVpG9+hth?=
 =?us-ascii?Q?cNhwRKfcXD0Eb72K8MYzVRbKsCU4zBxudzbi4gYIjmt+gEiW12SXhsDS13xh?=
 =?us-ascii?Q?geEpsK1N09mnIZPBQKGz4qAG7XkJ4Wn0I/9qzXy9QVK/fEaWmOhmYvAUafSF?=
 =?us-ascii?Q?d3Pf35xTDPKccmsq2JyebOEmK/OeNn2yhHb4LnfS2URMchsizqZMf9d+AAZu?=
 =?us-ascii?Q?tAlNkWkh4DVxLj6EAa0wZKANugiBNAJmOa4VJfxwm33QIZEDDbrqo97McD0z?=
 =?us-ascii?Q?CyrktcLD2ntLcFkDJmbHy9RAHrdiLJSniJvk7QsR+7kpwvQjHmOZNrQJFOOs?=
 =?us-ascii?Q?srB2BI1Bua6FtC40SXPvXjzoboVAIvPqQK09D/DoFeuOXJI1qr2uH1SxIQjd?=
 =?us-ascii?Q?HHIH1bProNEFtZmJXecF5FuQ2YLFbZxj8Ppq2314j04cag0b5ThqLukMy5Nu?=
 =?us-ascii?Q?I36RbpXVDltCnaEYC6ER0kh3QVo/bX3zVHD/vZ5lw9fT1H1R8ZrUFWyd6gty?=
 =?us-ascii?Q?URHSEsbZiCPc4eDs9GJKz4XGO1eLb5oZrFNGKhYnx+OR8hfBoyDE/pE2tDWV?=
 =?us-ascii?Q?+IRfYyvGWFiZ6dFytli6TW2K9LBZcAgSSSp9MwF5uh85sCQeoPI7JnC886OB?=
 =?us-ascii?Q?l49VwhB0AGGOuEjcYZR6+xYfeCBkaEJZlKal4ipXlbWqK+6TsJN1mQutcTnL?=
 =?us-ascii?Q?pZ1Xsix/XvRXhYSWqnfCnf7qrtxuFo3Z8Cx6OwdbeHhQgbscQ4B0Q1j0RNM8?=
 =?us-ascii?Q?NGL+x09MhJXIXOHLWv6p8jx5d5t7NgF5F96nubHfFYPPrvGLhlWBJJIvw341?=
 =?us-ascii?Q?zj1qnuZNRgsqk2zBbf64xAOZLQCJakyYGCN7i68HGzMIl93FU7DT20N0o+u9?=
 =?us-ascii?Q?PN7HHbbWF+Ct1HbkE74Hrxa7k6V2yIGnXZmO/hyAU6LUZmzWv2BpMORv5brO?=
 =?us-ascii?Q?vfbaMVZ2uYuetwzpOwPn77li75Qgjs1kydQJnw9yxCb7QmBN224S8s0x0xJc?=
 =?us-ascii?Q?Zqasr9wMaG/Y4OdiE8SGHOuhDTCYZukY1QQ1///yoCmc0QTYc0u/5bTAMgbP?=
 =?us-ascii?Q?rpYn9UtB1ZKylaeTr6eqB8duQ3iMxZiNGy/Icvw4Qs4EqNy7lEbDoefc6F2r?=
 =?us-ascii?Q?uHE/HfPj5hmuCKxmGrrz0Iz0Vfzb6Bu+PNBFo/vyXE85ANURiv6Q7H7hr0SM?=
 =?us-ascii?Q?VSL4h3Po7rqtfeftc4nciIEmckN1HDR+2zz4u/ETx6Yg6nPV3Vj/b15Rtlzp?=
 =?us-ascii?Q?xwmWfDAImeJVaWfSTgxpjT4uBjiWMQEBjfiMk6V+9m4P7yAdTNksnUoQuT/i?=
 =?us-ascii?Q?UnJ7wmm8DYjI2sBR6NiJZjj4TB3bp8ATjIjAlrFBGXREbSQDpEzLXxV5Y2fp?=
 =?us-ascii?Q?oChS16f+uN3SPs/inne2sSODsuuq4WjriDfwDUJqUh8Kz3f3sSy9rCw9fqYa?=
 =?us-ascii?Q?sp/RK4r0mEKsexc=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 08:02:36.7545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86aff9b7-7882-4f7d-c66a-08dd5705197e
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FAE.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5726

On 25-02-27 12:52:36, Jianfeng Liu wrote:
> Hi Peter,
> 
> I'm really happy to see the linux mainline upstream work sent. And I have
> also reveived radxa orion o6 before the Chinese new year. I have heard
> that CIX is testing vendor kernel with ACPI. And now the mainline upstream
> work is based on devicetree. I want to know what the upstream work of CIX
> would go in the future, are we going to toggle to ACPI instead of
> devicetree?
> 
> And it would be good to let outsiders know the plan/roadmap of upstream.
> For example collaboara is doing good job on upstreaming rockchip[1][2] and
> mediatek[3] socs.
> 
> [1] https://gitlab.collabora.com/hardware-enablement/rockchip-3588/notes-for-rockchip-3588/-/blob/main/mainline-status.md
> [2] https://gitlab.collabora.com/hardware-enablement/rockchip-3588/notes-for-rockchip-3576/-/blob/main/mainline-status.md?ref_type=heads
> [3] https://gitlab.collabora.com/mediatek/aiot/wiki/-/blob/main/mainline-status.md
> 

Hi Jianfeng,

Thanks for your interesting of our hardware. Radxa will open our
v6.1 device tree vendor kernel source code at the beginning of next month.
For ACPI vendor kernel source code based on v6.6, it has planned to open
at Q2 of this year.

For upstream, we will submit support based on device tree first, since
some common code changes are needed for supporting ACPI well at Arm,
it may involve lots of discussion. After most of IP drivers are
supported by upstream kernel, we will start ACPI upstream work.

For upstream status record for CIX SoC, we will find some public place
for it.

-- 

Best regards,
Peter

