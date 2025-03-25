Return-Path: <linux-kernel+bounces-575445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E16A7026F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1F4189153D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE2C25DB19;
	Tue, 25 Mar 2025 13:35:42 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2109.outbound.protection.outlook.com [40.107.255.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A8125BABA;
	Tue, 25 Mar 2025 13:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742909742; cv=fail; b=t/8Dtc/BpxXPI5A5j30s7qCtIkQhr7UBSd2/zFAZ2YQE2hLGQJpPCxoJjt5iuI5RcKCZ4oLty51xDPXoa48XvHkj43d83tuXoOICr+p4degrpjOR3qLpvtNXHa4ehS5xHld0jFN2uZtcWDxvbf0a66TOwdlCF9uXseze29bejh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742909742; c=relaxed/simple;
	bh=3FsQysnxkbNuI0uNjIt0YNH1OkHfyBEx3D8yKUYPhng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdgrS3Zyt7K/Ayjut3xUIE8s9cRlzpv35f6FgCklyeSZwyGoIMaPBuUIPg6Dxc9SDrLnZCe86z+ACqoYruvHIWxsnV85L7Hi7CttoJoinxX1L5HMbqH6IgKKkEcQesqf06SojSWY8T++b3SQmkGFOxXO9Z9TiVPiHndIq/pPZ9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.255.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXewqAObyz8I7Zg9blhtuNFkD8jwfMj2jd+GaBrzEr1L2emO13yVESVTpdaXd0xdtq66IsWQaTZxdMHsPTH8/wmYG5gpKz/I1GFs5WYh0FdSPE2o8W9seznhY5PEdIcdQmPazn58lEJUDSu5Da0UwNjZ/I7K9RkNumXaJ7wKYW510Y6rw4aoSK9EBXwXbJeP2ibWCYdBavSH/lXbsRg9uT8FxP2zujCcjcKugH1+FVcjk7TqGbcGKDHp0vzYOcNmfCy9HXmovxAMsjBMxPmvMHAFvsBOc7fI/yWzg9GrGoHU/KjdRHHOJw1BQeVPE7MSTIpp/xjmjSHmlZBADx8vgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krwxSfTcnqkuyEBDdF8ZGtdxffd0VKhnZhO+F48wdno=;
 b=s5DlStqknIvKEbiFx4rlGN8iSJ0TAvm2DGyOYLDkFaOhQUTkrvF5lf6S8OFsJ9taNT/gz01LqxpvIDtlHvCc1NELQmQeJdIWVq2BSUgrGCkGvhGBFYdYq7alUfEMddwGdfOUi02XO55Z+b6lCfWXkftLYr3fS9GH/+05sZwhHF8NvYT/UbFVAYQwIsjAdfvxq4snXaATv7yrlDXfs/xmAf24gTiChH0nxd2ouXik9jACs+0vh7KFQVOkw5bT+7ZTUGwbe9e8tVAfvBkLA2DG9FsP7ICfzJFqUc2EsergPbFCwuRs8j51L6lJ6Aeh3cF/jyI5lzZPPCcBJOFaz0eMvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR02CA0037.apcprd02.prod.outlook.com (2603:1096:4:196::8) by
 SEZPR06MB5344.apcprd06.prod.outlook.com (2603:1096:101:64::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.42; Tue, 25 Mar 2025 13:35:33 +0000
Received: from SG2PEPF000B66C9.apcprd03.prod.outlook.com
 (2603:1096:4:196:cafe::66) by SI2PR02CA0037.outlook.office365.com
 (2603:1096:4:196::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 13:35:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66C9.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 13:35:31 +0000
Received: from gchen (unknown [172.20.64.84])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 85CDC4160518;
	Tue, 25 Mar 2025 21:35:30 +0800 (CST)
Date: Tue, 25 Mar 2025 13:35:29 +0000
From: Guomin chen <guomin.chen@cixtech.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Chen <peter.chen@cixtech.com>,
	cix-kernel-upstream@cixtech.com, linux-kernel@vger.kernel.org,
	Jassi Brar <jassisinghbrar@gmail.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: mailbox: add cix,sky1-mbox
Message-ID: <Z+KxIRVRRw1slKqB@gchen>
References: <20250325101807.2202758-1-guomin.chen@cixtech.com>
 <20250325101807.2202758-2-guomin.chen@cixtech.com>
 <174290730775.1655008.14031380406017771195.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174290730775.1655008.14031380406017771195.robh@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66C9:EE_|SEZPR06MB5344:EE_
X-MS-Office365-Filtering-Correlation-Id: eb4dd64d-cf22-4a4b-fbd9-08dd6ba1e9f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BeY6y/oNN/82MaQDhQyKgcqQEM3nYBLAoFXmS9YYEJerBMqdjU6EJ6BVRxdE?=
 =?us-ascii?Q?tauuOg+ABu52M6o9QY8beuNWoyolmfQv1h7a6brPc090yW7RdHMMUdjmFxRp?=
 =?us-ascii?Q?Mpe+rvXZLeZ0e4M7pwbf8VinhWXwk8qqpxH/8+ZzIK6KkKR4kb0SKiOaVohF?=
 =?us-ascii?Q?DXKPCl1wUkIlrVxPxwQ8aVb5MV/D0P74cV/eYMCylCMW78cPRVyt12jlZ8p/?=
 =?us-ascii?Q?04H7aKfLjt0eFJ5sWWCP1ZmTRbjx39wj+nUNnqgnjH3UoFpM9teUqTQdFi+g?=
 =?us-ascii?Q?TBdHaoATGIeLtn/O1+n/j1uS/qCnb/ixLoXkIs7XAzABv+zqZbEuE/XxAooj?=
 =?us-ascii?Q?FNCgEqD2H1Ufh6OvyEBaKD8rW7Uq0Z1DYV8q3oaJX74N8dG43ZVRCzh5F6MU?=
 =?us-ascii?Q?6JP9gV5NcqaDWjWLXK/6VLo3cOSOqKal6zCg2H6q5vl30D2xOWNSfGVxVSYi?=
 =?us-ascii?Q?bZb+9bvmNICz+hzfoR08heIMadOmDHgztAgltP2cn4jAJZ21tbSDRWbhXofp?=
 =?us-ascii?Q?8oBNcTitGLHFB3jfGVTbPoaW9vlNGn+sulmZQ2sfUuV4pxYr7G+fQqDIig6K?=
 =?us-ascii?Q?Qr4oH0KKpeAiBVJ37qkKmDdb53TfUH6S+mHkIGDYD4GJQ5C9+VTqQ5jTfGsF?=
 =?us-ascii?Q?hmy5reeW5xo4cpoOUCX0IWbp+THWk19gAUnzr7rsPVpsNqL4MJUnxqkI2iwi?=
 =?us-ascii?Q?I5jWbLJoNXBqG2oZCVSX22j95ZXxfXXZO0/2RuQg4NytxjSvG0zebnVLsdHd?=
 =?us-ascii?Q?BbHvJd+Q+7aduogx73e6e+J4d7c/u7z3XgVCpLe+RFOHFXAKHQ0qFGzT0NjL?=
 =?us-ascii?Q?cv7wqR/b9EBTAXEheAwM5gsIkL49QRm1UKywR4bE6XWn2HSuuZiUe5NQueAG?=
 =?us-ascii?Q?HqosAUjU35jcA2zvLuh/opQRIV/n9CmjURik78MsIMN9k+iVcowW516HMuA1?=
 =?us-ascii?Q?NPKLyjchIc2fZjxnEhLmORta0sRXUa42rnGznwypYzZX7NTg/2wu1i2Nw63s?=
 =?us-ascii?Q?4TFBvbWgrkVsiRKj4RXbb1Tk29UlubTtpNFglHNG8W2OBSAx9BuHCD5tDaEa?=
 =?us-ascii?Q?pu/mQXwVkBr4K0jv42Eqg0nJp6SUk04od0Pkuv412pwiBhJlNfUwL0yJ6gTe?=
 =?us-ascii?Q?jodu+mEq3M//zMfOXgaBDaJyqluNZUiQTMXqNGUkoiz3TL7KapG5+7hnGRX7?=
 =?us-ascii?Q?fHVGgsH7x84t7Coxk8N6jQBdNdrPNQ0OeLX6A3+cMvB610RRBvqV2kcG+0eS?=
 =?us-ascii?Q?k3FMPLqa1nvP9dC8AHloBqU3oAejY4sl8PI9305dtMd6XQ47cCcmghFKu1Sm?=
 =?us-ascii?Q?lZKuVWN7ekrP+cJ6Nvl+FeceTjCP23F/ehkGh25bTG0FxfwVFScW9lwGWA0j?=
 =?us-ascii?Q?LOlWmhahJriWS6ClGR20zTd/5FprifrMdxjys90NvyTuLw/tzWiBSweyOCB3?=
 =?us-ascii?Q?MTUk4VxvSoM=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 13:35:31.4075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4dd64d-cf22-4a4b-fbd9-08dd6ba1e9f8
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66C9.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5344

On Tue, Mar 25, 2025 at 07:55:10AM -0500, Rob Herring (Arm) wrote:
> [Some people who received this message don't often get email from robh@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> EXTERNAL EMAIL
> 
> On Tue, 25 Mar 2025 10:18:06 +0000, Guomin Chen wrote:
> > From: Guomin Chen <Guomin.Chen@cixtech.com>
> >
> > Add a dt-binding for the Cixtech Mailbox Controller.
> >
> > Reviewed-by: Peter Chen <peter.chen@cixtech.com>
> > Signed-off-by: Lihua Liu <Lihua.Liu@cixtech.com>
> > Signed-off-by: Guomin Chen <Guomin.Chen@cixtech.com>
> > ---
> >  .../bindings/mailbox/cix,sky1-mbox.yaml       | 80 +++++++++++++++++++
> >  1 file changed, 80 insertions(+)
> >
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
...
>  l,.*', 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/vendor-prefixes.yaml#
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250325101807.2202758-2-guomin.chen@cixtech.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

Thank you very much. 
Although I have already run 'make dt_binding_check DT_SCHEMA_FILES=mailbox/cix,sky1-mbox.yaml' in my environment.
I will try updating dtschema and re-check it.

Best regards
Guomin Chen

