Return-Path: <linux-kernel+bounces-575469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C69BBA702CF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09E6B19A26E6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DE225D205;
	Tue, 25 Mar 2025 13:44:39 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2105.outbound.protection.outlook.com [40.107.215.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F00125C718;
	Tue, 25 Mar 2025 13:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742910279; cv=fail; b=RfjjzhLu5EFcwQR/1sx++jvoyDvVYLdFq6zN7LoN/U6WSgyFxcHaySag6bnqnjgN/NCwVymExPOdv8mZqSAXqi95RyxZMkfBclTwuPMtQ2WyOYf60CgxdbQaRwIam9AacAULzCa8SC0HWb8baaoHWa0aD7K4G3/jJwhQDXbMFi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742910279; c=relaxed/simple;
	bh=FPdCBvPXZ0iTUKExjgA9+m4UTn/ItuT52RovvRiXy6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2PdPhEGWQ372R0OZQwXcO3aA2SnyXTAc0AWDRRboJMVdlldPLHg7xgxnqmD8e3oCk6yOrF8VVpBA0WL8X+hxpc+ve9bzqLTlldLDTvVPwcnaXXyYeojUwSGHWQBQc79q2JDjbE4zrrBTm+NIrWu060ZBMTuoTBHz8YAktsnsp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.215.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIriYoLkgx/MNBWLi4Yos9zDXSeqBxOsPbu1oxz9hoD8cM/C8k5Bd8KdMtvBCL+DSi0nVQrsk/KurMtszzbjNqZ73LShsa2zhbvylQhdy2UShpYy+8fKd0SgRw2ppUnb40zvspcygSpKKrEPCIwuvxEU9E79eIMx/dbV4s8oocNnFEwx0YUySLEh3+B8xgCc/VKjLiBx1hINOQtfRVTFMR+vAj/fki0e4q66SmSqWoG6vdSJZI+Cc+OEi8Vy0ndeu6A3AJGqM7RBM0t45tjJmcGpvqs6f7hG9qV8poatybWn4YwpzcPLZ/Y2WrEkitzD0hWPLJr0CRuoRb0ITfVODw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ouee1u7iiS3DGlQQGSAH6t+QCWivpvooSGYluQ3z124=;
 b=HmTk41k+rKCjMnIsa/xmKgC20Uxixikx3TMqxGOLDcogSkR80O84M/ipZMMxoJoM2tEqUv2BGL0N9qo6A0dvy65FukLv9bwg6utl/9ICxtZeX8jLHLSh90iCv9IvFesuhQx/72J/wfFw7Q2C17iqVoiOR8DJZps3xfLVmDshFUsnCIB9XiOHjB4SbvNbcme7pcc/AWctssMtNBeiPpK/nfVyfqLgwzgVvewZGlju90jy4k7JpiKuJH10tCHHsj4wma0+8Dhrogz4YYqwTA+Gnki1FppwerJfgZLqudMlJcCDEVDCKHM/OjllzQrSMCEqYWA1aCc9IIGcPmwrixz6lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCP286CA0294.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c8::6)
 by SEYPR06MB5182.apcprd06.prod.outlook.com (2603:1096:101:8b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 13:44:31 +0000
Received: from OSA0EPF000000C7.apcprd02.prod.outlook.com
 (2603:1096:400:3c8:cafe::e2) by TYCP286CA0294.outlook.office365.com
 (2603:1096:400:3c8::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 13:44:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C7.mail.protection.outlook.com (10.167.240.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 13:44:30 +0000
Received: from gchen (unknown [172.20.64.84])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 921A24160502;
	Tue, 25 Mar 2025 21:44:29 +0800 (CST)
Date: Tue, 25 Mar 2025 13:44:28 +0000
From: Guomin chen <guomin.chen@cixtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, cix-kernel-upstream@cixtech.com
Subject: Re: [PATCH v2 2/2] mailbox: add Cixtech mailbox driver
Message-ID: <Z+KzPHxTRPbXbYao@gchen>
References: <20250325101807.2202758-1-guomin.chen@cixtech.com>
 <20250325101807.2202758-3-guomin.chen@cixtech.com>
 <410f05ba-73e2-45fd-9d31-0c07d648cdd5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <410f05ba-73e2-45fd-9d31-0c07d648cdd5@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C7:EE_|SEYPR06MB5182:EE_
X-MS-Office365-Filtering-Correlation-Id: ef6dcac5-0b8f-4c3d-fa75-08dd6ba32b7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fkhIvMp3c9SDCbYpNE8a/f+SrK8kJwRtiAhb2xuBrv7Y5bpNK6WG+PAbLygk?=
 =?us-ascii?Q?42s2U4oR14v5vUAc8L81So2ttCzXItK1X5MJbS+CCPNVbOgbqlpD+rleM4OX?=
 =?us-ascii?Q?vzm4Rlab9NkI89/OvQmMddPMHlfKMKleiec8EiI9bqstm2KcolTlRFo7kOhD?=
 =?us-ascii?Q?Kg8J7aJJqeY5F0IExgSoze1/uMbT3fFNdrGvLr1SJntmIFv+ZIlD2FoF7wUX?=
 =?us-ascii?Q?dYo475bvZAdgE5trvdMdLSO6ny8S+qFiEL6y+d5tJKt4uRFWmDfgrTyq2LSK?=
 =?us-ascii?Q?GxBlx74A2z7W4yMkMa4/05Podw/He5Sz5JuVBtHHMadn2uPjWuS+QndExZhk?=
 =?us-ascii?Q?BYxY65UR9rzobiP8UeQlD/n1qaX2tcvw83MNn2/aauMpZu/gJEJL3GMBZzj7?=
 =?us-ascii?Q?OMWd1KEuWEZl2v3ShHcRUT+oVs0wogsHDA2G3rHvH9K7q11VoUwuwwWrPTKe?=
 =?us-ascii?Q?HZHjKPmk340nR8+IXxZvVUmfJRrBdUBwSnpRddRUWCDikIwOvfWS/YKqLDxU?=
 =?us-ascii?Q?ZUx3mavbGejgn4k1tn1N/izluvhZWjZgfzDPSunt/URO2mN1BLVkpizmNjNn?=
 =?us-ascii?Q?aGQrh5ETONDEoF9LDDq/A9Gi1LKySDDkemDuLForfME+WkAzf37T5VaHuwC/?=
 =?us-ascii?Q?yTZOj+fMOnFidCCnuT01itoioY+Ecp2Vlu5rTHLFpoge2xbkhh18RoGtAxk4?=
 =?us-ascii?Q?z2qPNJy8I0TeVdXI19CY2c51eVy4tKmpyuCYXWXbnfGwZBbOz7rPl8SgkfnU?=
 =?us-ascii?Q?OXlXlW/bpuQcJ65RM5My/AePDWTTWTGoT8aJo0/HMVZdULxM+s11Cg1ce/Vn?=
 =?us-ascii?Q?TjKlhkJAxYj0GGMgU9yXF7985Kpm1juosVF1rncDhsonDth0ooSH3EqdlOxn?=
 =?us-ascii?Q?K/duiTCNGJ/zpDsRidKHmzSwY0PVMuketmv0H7g+YVLTyHCwUUSJO51FCGPB?=
 =?us-ascii?Q?tzfVYx2yIcsmKFOX+2qYtxMsPWHGyZ5yGznG/zZyUIDiTfnE3UShKjUd1DlA?=
 =?us-ascii?Q?ZzVQ/y4nBJm5vkyUvsxJuUvwQ5cmDeB4nh7/r88YcPysJODmtfGGRY8sCgYL?=
 =?us-ascii?Q?LkDKhsDw4Zv4iXRfDWjy61OW/AroS1z/QkU7cw1I9FcXXV4zSei9rwIWg0Gl?=
 =?us-ascii?Q?bgDijouMLPgZ/JRQogbGe1EmcTwV0BjidNmhV5HSdV7ZzwSinn2izezps6g+?=
 =?us-ascii?Q?s7zWRejIaxKqRuSWzY+yFDR6/MnDQ49CCLgEXfmvU0RiyhjFFrF78w46z6w7?=
 =?us-ascii?Q?YLE0WUIhAggJ5UV/L3VPyhhmWFxYqW+ZMIY0XR/Rz60ubMfbMgzAoCpxe9Uc?=
 =?us-ascii?Q?5uQFvq9JUcS/ovR11mOWfCY2xsI568lTOICeZaYRu+R73+vTeUXTL35XOnbV?=
 =?us-ascii?Q?/kaUN38CYCtZdqrDrWkXxpkEvOsuCS+vgVEsQt9xXvlNWmDm2oPZH8OQXUTk?=
 =?us-ascii?Q?PPubprorxY4MfLdDNlL2h9iTHKte4dEcEqzFAPrXFV6b6VVUIVmBCnI66VDR?=
 =?us-ascii?Q?7gavAlHYHU9UWgI=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 13:44:30.7626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6dcac5-0b8f-4c3d-fa75-08dd6ba32b7f
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: OSA0EPF000000C7.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5182

On Tue, Mar 25, 2025 at 11:39:34AM +0100, Krzysztof Kozlowski wrote:
> EXTERNAL EMAIL
> 
> On 25/03/2025 11:18, Guomin Chen wrote:
> > +
> > +static int cix_mbox_startup(struct mbox_chan *chan)
> > +{
> > +     struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
> > +     struct cix_mbox_con_priv *cp = chan->con_priv;
> > +     int ret;
> > +     int index = cp->index;
> > +     u32 val_32;
> > +
> > +     ret = request_irq(priv->irq, cix_mbox_isr, 0,
> > +                       dev_name(priv->dev), chan);
> > +     if (ret) {
> > +             dev_err(priv->dev,
> > +                     "Unable to acquire IRQ %d\n",
> > +                     priv->irq);
> 
> Odd wrapping. All over the code. See coding style. Please follow it
> precisely.
hi Krzysztof
Thank you. I will carefully review the coding style issues you mentioned and correct them in the next version.

Best regards
Guomin Chen
> 
> > +             return ret;
> > +     }
> > +
> > +     dev_info(priv->dev, "%s, irq %d, dir %d, type %d, index %d\n",
> > +              __func__, priv->irq, priv->dir, cp->type, cp->index);
> 
> Drop or dev_dbg.
> 
> > +
> > +     switch (cp->type) {
> > +     case CIX_MBOX_TYPE_DB:
> > +             /* Overwrite txdone_method for DB channel */
> > +             chan->txdone_method = TXDONE_BY_ACK;
> > +             fallthrough;
> > +     case CIX_MBOX_TYPE_REG:
> > +             if (priv->dir == MBOX_TX) {
> > +                     /* Enable ACK interrupt */
> > +                     val_32 = cix_mbox_read(priv, INT_ENABLE);
> > +                     val_32 |= ACK_INT;
> > +                     cix_mbox_write(priv, val_32, INT_ENABLE);
> > +             } else {
> > +                     /* Enable Doorbell interrupt */
> > +                     val_32 = cix_mbox_read(priv, INT_ENABLE_SIDE_B);
> > +                     val_32 |= DB_INT;
> > +                     cix_mbox_write(priv, val_32, INT_ENABLE_SIDE_B);
> > +             }
> > +             break;
> > +     case CIX_MBOX_TYPE_FIFO:
> > +             /* reset fifo */
> > +             cix_mbox_write(priv, FIFO_RST_BIT, FIFO_RST);
> > +             /* set default watermark */
> > +             cix_mbox_write(priv, FIFO_WM_DEFAULT, FIFO_WM);
> > +             if (priv->dir == MBOX_TX) {
> > +                     /* Enable fifo overflow interrupt */
> > +                     val_32 = cix_mbox_read(priv, INT_ENABLE);
> > +                     val_32 |= FIFO_OFLOW_INT;
> > +                     cix_mbox_write(priv, val_32, INT_ENABLE);
> > +             } else {
> > +                     /* Enable fifo full/underflow interrupt */
> > +                     val_32 = cix_mbox_read(priv, INT_ENABLE_SIDE_B);
> > +                     val_32 |= FIFO_UFLOW_INT|FIFO_WM01_INT;
> > +                     cix_mbox_write(priv, val_32, INT_ENABLE_SIDE_B);
> > +             }
> > +             break;
> > +     case CIX_MBOX_TYPE_FAST:
> 
> ...
> 
> > +
> > +static int cix_mbox_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +     struct cix_mbox_priv *priv;
> > +     int ret;
> > +     u32 dir;
> > +
> > +     priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +     if (!priv)
> > +             return -ENOMEM;
> > +
> > +     priv->dev = dev;
> > +     priv->base = devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(priv->base))
> > +             return PTR_ERR(priv->base);
> > +
> > +     priv->irq = platform_get_irq(pdev, 0);
> > +     if (priv->irq < 0)
> > +             return priv->irq;
> > +
> > +     if (device_property_read_u32(dev, "cix,mbox-dir", &dir)) {
> > +             dev_err(priv->dev, "cix,mbox_dir property not found\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     if ((dir != MBOX_TX)
> > +         && (dir != MBOX_RX)) {
> 
> Odd style. Please follow Linux kernel coding style. There is no wrapping
> after 20 characters.
> 
> > +             dev_err(priv->dev, "Dir value is not expected! dir %d\n", dir);
> > +             return -EINVAL;
> > +     }
> > +
> > +     cix_mbox_init(priv);
> > +
> > +     priv->dir = (int)dir;
> > +     priv->mbox.dev = dev;
> > +     priv->mbox.ops = &cix_mbox_chan_ops;
> > +     priv->mbox.chans = priv->mbox_chans;
> > +     priv->mbox.txdone_irq = true;
> > +     priv->mbox.num_chans = CIX_MBOX_CHANS;
> > +     priv->mbox.of_xlate = NULL;
> > +     dev_info(priv->dev, "%s, irq %d, dir %d\n",
> > +              __func__, priv->irq, priv->dir);
> 
> Drop, your driver is supposed to be silent on success.
> 
> > +
> > +     platform_set_drvdata(pdev, priv);
> > +     ret = devm_mbox_controller_register(dev, &priv->mbox);
> > +     if (ret)
> > +             dev_err(dev, "Failed to register mailbox %d\n", ret);
> > +
> Best regards,
> Krzysztof

