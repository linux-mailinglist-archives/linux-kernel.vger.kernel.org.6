Return-Path: <linux-kernel+bounces-191039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617198D05D2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84F901C21811
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AA061FF7;
	Mon, 27 May 2024 15:08:52 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224521E868
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716822531; cv=fail; b=apaF/7U25RbJdkInR6pLZ0gtWVMkC4ZpL67gk4l0z9PKifhu8ZnpepSb0t8OBh1kYYwy9AautBB7lMn8wf7StegAkOj/B//+CShrSP7Pi+MWmpy1NaJTXjUfwFc3lSvENLVGC38DGQJOXT8A3h/8+Fq3Ku/mDOuLdhw/Es7tf5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716822531; c=relaxed/simple;
	bh=1/U29QG71nIigJv0l/Pzhqt41rskKjfrkfx2Tc22X4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A0dCG6Tm11gPGW3i3g2B2FXJl1dy/AMdPbXCY/1SOWd3z3JjD3f+83fzDLwvruyiaZGitjFI9jsirGwiCbMz6OKFZU5QK6XCRkdnoI+FRooyYd0388shjrAgeiAKMdkO/mYqzUu2eyuFTxaVRWcd8NkX9AmEsvg7EoA0nlyiOjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44RF3Dqt009072;
	Mon, 27 May 2024 15:08:38 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-type:date:from:in-reply-to:message-id:mime-versio?=
 =?UTF-8?Q?n:references:subject:to;_s=3Dcorp-2023-11-20;_bh=3Dwr27dtn7B4/n?=
 =?UTF-8?Q?EA2N8OzVnBnxvSPxR44yQHwFSzExMmk=3D;_b=3DT3CZfG0XxX/PiowX4qcYZwO?=
 =?UTF-8?Q?I/zCujpnZvCxD4Ct6mgaY4U+m7qQJmhw8hi5Uzp2wcKkQ_oChJJCyXo34G7K9yR?=
 =?UTF-8?Q?wVnHqS8EGwKdz5owta7JTRG25dnlupEw/IX2giM1t/OY/RFJVxg_PWXhoWPzyOQ?=
 =?UTF-8?Q?X1+VtNNG/uhUvQYthMa/fR51uNlyOJq+1te61B3JfenO+YKBg37oexdKL_TDJr3?=
 =?UTF-8?Q?2mJ7ylUde6L8koPxEnOyFpcffnb+JZ+5qHrbwnoKJYZYuXnFY+r+FDwh+YdwvLZ?=
 =?UTF-8?Q?_g7uNHdFNtzJsc7CJKTmpIMohUmt5B1NVVUtgo6Ua3hC9r+sTZMlHt4SaCv2F34?=
 =?UTF-8?Q?8kuo9E_lA=3D=3D_?=
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8kb2qje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 May 2024 15:08:38 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44RCvkKm016170;
	Mon, 27 May 2024 15:08:37 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc55vfhqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 May 2024 15:08:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXgxwtx9mob+savIsvKe4+uKIuW7yu7bBRqs4drPgW0udXT7ctP3NM71VhDCfQmooXFJApFAjWzgAmzNXF/LlkToyQlD4MOIsxvJF0pQAWgRA+xpveZS8FhbpN4zEgYwdwmkeMe7e2aZcGIrmebyUoI0TsAYqXTMKzewG040Jo90fpiheD37uVD8SLvtYfwKqJDEJ81AVcanoc20D0Aj0ePznJyhRMIDT1zchwNRAtZnYBLPKJunwK64HzblN1CSCk0vGrDYZMtaV5zLjaZ6AV2+Amxxwb4jlq7pGJPYILxfdqmoiCavP1f6ZpUOhFlDQLHRb9f8OteDRB+xiE8I3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wr27dtn7B4/nEA2N8OzVnBnxvSPxR44yQHwFSzExMmk=;
 b=ar0F1alBB+GwNZ4aM/zap68mIZywERODuOpJUGh+7JZkZ28/fxoxKZDXbNUv3fWydcfwFEGJvKYMs40c6URNktIRbmyW86iKfwehImlvnFRgE8N1fK6RGkg2PxFOfJRLPnH29CQEvA2+J5RM60fm49DfHuzggLcp1efuE9ZgFID4WNzjAPIA1FbJDWrJbL2DIHAK6nOCuyiIAafpobMdq6guemSF9Rynw/O8RdRx+5Z3XKxAfAIBnNkty+0yfQ8fxd3dCik+U+lR4q/bx1BCLGF+/3NSzdcjEsC59C3VrTnXlfAGSF4utF59b/ouVdNOz7jSaUUYoV+GjYnrx1DRqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wr27dtn7B4/nEA2N8OzVnBnxvSPxR44yQHwFSzExMmk=;
 b=mv9we65wf5dDl7viOte3hAEg1GqezmPbzzodwKPKt275FYH8hEV4D9icLO8KxMtazkpDIEXbG+Fw9JNLsnkM3dEzNdt75MY1gRIL9wBXoXa04LNvV0pIvMyfeOPvOqAW0VFcFYPPj/e8WFWY5qDG6K32IhQGJeFkQyuEyS8doOs=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA3PR10MB8116.namprd10.prod.outlook.com (2603:10b6:208:50b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Mon, 27 May
 2024 15:08:35 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 15:08:35 +0000
Date: Mon, 27 May 2024 11:08:32 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: JaeJoon Jung <rgbi3307@gmail.com>
Cc: maple-tree@lists.infradead.org,
        "<linux-mm@kvack.org>" <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] maple_tree: modified return type of mas_wr_store_entry()
Message-ID: <ojvx3usqalady6zp5cwbqjrvtrhjgym4ai7hagbpjvfkfztsu3@2o6nq3hgiblu>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	JaeJoon Jung <rgbi3307@gmail.com>, maple-tree@lists.infradead.org, 
	"<linux-mm@kvack.org>" <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
References: <20240525010223.1704-1-rgbi3307@naver.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240525010223.1704-1-rgbi3307@naver.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0308.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::19) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA3PR10MB8116:EE_
X-MS-Office365-Filtering-Correlation-Id: 33642759-5220-4a28-29d2-08dc7e5ee152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?aFrxk+fFtsS2RDU5jBun+Mfe5w3zWRLpEuGZPEl/Xdg9R3JG2wSvPYDh/v9C?=
 =?us-ascii?Q?GDAoEIIXaQYLJTOPgaY3h5JOgjBk2pujeHV0lchZz9xlCzxjf/nPwab5oGTo?=
 =?us-ascii?Q?u8Ly2Vsez4CaSQvs2ad9hlwCU6cqDtup5fqyZQsJu4DNORWOc+2shhYbAQ8/?=
 =?us-ascii?Q?ffHwz5ffe08ruTg2PM5R8bOFGxwtmWdX2Lnx2aO20iACmgpA+YYE6F1aLTAN?=
 =?us-ascii?Q?HqK1P+VaQkvpDQ7Jt5xnKKqReeuNXuifnCgz1guxSoPFh1KG85fHgyT0Jk8n?=
 =?us-ascii?Q?DqyOHDixaCxVUH1LbCo37UiHOJaVWuwElqlm2BKr2dDio6ghVyiiGmhODd1K?=
 =?us-ascii?Q?aJv3j9FEGaos9WDrUShjpDkZp7wdWjpovjhrTlM9u8LMCXtDY0EQCklUFNd1?=
 =?us-ascii?Q?evNDj5iiJ9nO6dMIVMd291pWmeMnXhdIc3zxYQe50LU5+DvQx9nkaEZ/TeiM?=
 =?us-ascii?Q?dDwlHC+Q3vj/ebLnWykyWByx04QfrDFSIrsRykAbplspWeV98ocb9AgVYFV+?=
 =?us-ascii?Q?nCiVXglJEIh3a3uHh8YNlEyDn7TXnSpntSAX4tZEQgPxBgHS8FmpQshR3akR?=
 =?us-ascii?Q?XuUo3I6qkIf4z7JSBIdvIKtAT4Qxaqkf7wPAmTyW9qh4OXfR/O9aWOzR0gq/?=
 =?us-ascii?Q?SplKXfyPiMYNFsuZMouxWJkq9gXyqc7XeRWWJ7zbLQyGnW0fBQ/00yxMyjnp?=
 =?us-ascii?Q?sZ+UounFc+ch5vSMbq2IPonfMa3QlEHWpgahFOsFqquYijR975aCeqdnfRUD?=
 =?us-ascii?Q?tz20XSjE5Vdl/FKGkdMsO3AbhNp2+OvNaRyzIi3qBaXmIPQ/UK4fobOO6y8U?=
 =?us-ascii?Q?oNd8+wB76eh72mJ5Mp79QAKss9GSta1XExwD9ZH4ibWURFj0srrVxtHLO5Cg?=
 =?us-ascii?Q?GkrjD8bd0Wu0ypBWJS42LeAp8cYDK8WHIQ53BZI2fpcFMNCWLmgGqOaEeWmt?=
 =?us-ascii?Q?qZR90sioiX6wsH3aXyEybinJG4tlsQIceSCTuQBHJ3uBWkOhoHaMNAUbJRlB?=
 =?us-ascii?Q?Kq5KFsUXxFluurpxoiOiXM6jgP5JbVLhfwb8XFlC85RlvEWQ1EsA2aonwEmn?=
 =?us-ascii?Q?IDWhgopheSYWbktWbEk9yd4l+yXKJT10Uzhi2w0oTLurHtpTqo6VRpb3Vy7Z?=
 =?us-ascii?Q?vEOdkFcZWu8jdDc92P9OCP7jJhy0KXI5g3MdcQb95WsPZ+dqVncjJXfPS/Hg?=
 =?us-ascii?Q?F/qt2sEx+GJtkCFdy+P2YhWO0KhSCJ0eXTdwvhmGq8qAq3Suus9VqNJUX1Vv?=
 =?us-ascii?Q?Scjfiw2lwjgeKOeHv3sMcWfTM4PlpavPYZy2l5MbBw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?INgKCIc66jvqH8erSRKKJbbA27pZ46D4JiEqBYzqYyzR7vcAuWn2owYwzdRi?=
 =?us-ascii?Q?R0m2qYlaqXDRWFFXz793L+TG4xOggUCz1AtRtW+TE3AQYARIQX1FFOfZhPLx?=
 =?us-ascii?Q?BBIfQTI8+04PqtaXKzL6g6cJzWJk3idsKKjhUXuctFMM7VGI7g94F/kLjI8f?=
 =?us-ascii?Q?w6MX9GbeZqI/6PxjSMW75hdJzfxRWKxFbiF8aa6hASso93tvEUwNApDbojS0?=
 =?us-ascii?Q?sjixk/qOq318J+hxAw9lneYGuwrwZ2Km3HOhMzPqeU+WgpJwfHaR/LHoVctS?=
 =?us-ascii?Q?OftLVHQUEAURbCVO5ynjZ5H36p+fjH/8DuWg73yCO5Ofup/ru+nWq7A/4OKf?=
 =?us-ascii?Q?8XMbYs82VnD5b6ne4bweuTCsBfNKm0TTd7HkhxuQ8k3OP74/fuxqhB8ommWR?=
 =?us-ascii?Q?ANW0vfwDzVwBK1ZCR3rXQlgvLXpRDJi7gEqE4DTDF06Mik6L+DZGcxjAiUNy?=
 =?us-ascii?Q?m41yMTKvELupmOA6AbgbvB6keXdOTI/waXRTR+W3D5WfCjkrpR1zBqsBuTNX?=
 =?us-ascii?Q?V9YoIDQMgN3PMCL5Jml/h/hCrf1W8NN1Unl2b60GHzJP/Yh0yfUegCP8mdgG?=
 =?us-ascii?Q?WJrwHLfvBu8UhCUTW4tn1bGnz95E2GgfasATv9sdhHttuje/vlWnq/mvQhpt?=
 =?us-ascii?Q?9C2iewosjvvZjgca6UbIVC5bhLrGt4mkgpzLK/UuOzD7y8u4U51QeRsI72hP?=
 =?us-ascii?Q?ri/3QnxTROywyJeNxbZrWAbaqgnCnc8/Jy5tzQ/meYkIfoW59MiHp6lAkt8m?=
 =?us-ascii?Q?gXg0hLq2o9M76D8eXfzXVFRwPVv5HtSC1ol+5cftDAwY2kLyO2OrZsmJZnIR?=
 =?us-ascii?Q?VJ8ExZCe8VKgmQRbAsyzBVLU8zjb2KLxSPCGOMsQISweK3AJAyEmnGB4PoLl?=
 =?us-ascii?Q?S8nJ10H1cLwFgADGNjTut/e33DTvk4q94Ce92iGuIeKYLC9I4+U5MVRuJWgJ?=
 =?us-ascii?Q?gRYHw5sLWhpO3XHtYz/BZ5jltQRZoeaC8qP63+30qInLBvJufCn7k0UoTlIs?=
 =?us-ascii?Q?4gt6HnQJjC/8H7TimEQ3gpwOCKwUc3XfV0nLhPdxwWcK2TvwebEb2/jleYFA?=
 =?us-ascii?Q?RkgUrlXJvqE+8F0FbS9IzxXY4lUOL4O4pHyyDLPHiWo5LgBtk6IjiZzzMczP?=
 =?us-ascii?Q?GJ3eTdRYSAWM3fsta+1DIoZRnLrlQlTZeY/GosHc716tAlHRt1jlUEGliz7j?=
 =?us-ascii?Q?BhLdmaRobVbCW7YeKwi8yhXzahuJJ0WaPS/5N8cUvJnYlySuvHNwVFtpP/3e?=
 =?us-ascii?Q?j+ZJjXS73Xq9VaJ1oEQvoltv8vD4TGCJPWNLtOngecvFsUTLHvBJHKTW4mLN?=
 =?us-ascii?Q?FJzOplFVwQt5T2VgzNgeWLwBaEzpZ2af7UpzlLF3pc6wtbN5jVWdyeHoIJVL?=
 =?us-ascii?Q?3HUHeI8fd9yncTy6ll+rlndFvvNbh1be8hmjgsKrV0QsxC4v1RMVVPAX6pUd?=
 =?us-ascii?Q?6u6KK0gICYX0YiQdXDb1q+mWhfOl1bnOAXep6V9dqFed6ZvhXEFz8mbeCgCY?=
 =?us-ascii?Q?yfvLpwNLC7Qw5S9H/X88avvMzNIxRY999DIHVrrl5unaCNHa1rnN6p8+2Nb9?=
 =?us-ascii?Q?o5KaQVth4nt5BCrY0Ns4sNm3PqRu02b5CHsLbU/x?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WAa4lWZgLEEqw6WRkJZKiNtbJWgKHoHatu+CDvtl7b5Fy9+AAK/71W5l0yxtOM/UBh6fvGoHKkvsytEROIr0XxNXN6rt1R4Giod8aPJKN8T8+LWia90Po/5rXahQqOYE+p++2T1f/75SYrM9OUR1jSmbcMKVJx8hiUz7iU7c56yMF2m9mHuvBWMBijRjNA9SLloxNYq58XIOKSqtbdI0PLPdaWJY77ilni6KSOBGQxGtswb1GgaFiVX4tMAd/QvNE8oldDoVlztPlbMa0kdwLZFVyWeggxHCSasa9asy0cDojGmYTbO0mdxfOnsTE9sn2wd8W0+sc1tctAol2vrPVInB/WLQpQYFuFw3GZmvtVl5mOy4hVXvsBrNrhf1LxPf4KBQZBfeUyI/ZiDY4YKqmuqxMQvokitj3xpx64YN/zso+J6sihF3sqZ7+FWcCzR8S1k9cLtauG6ImnfvQ6TUgGtdkPiVRVVl4ly8+4lVrEiv2qSnmI+O5iB2WiEXba4+frSnSHdZpx6Z1RHE7QQKUH9EejSLh8isDv/Tw1eoGbYizDZGYVg08kZZq3XXj89yWL+mburH7ZKOa19n9utKsJgU37tItbG8u+7wz3OcsYg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33642759-5220-4a28-29d2-08dc7e5ee152
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 15:08:35.3487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Maj17JIoiGheFprWJ+o3o/fhQoKE/Lmvg+YBpnUKH3hPMSMtO7zBZTfln6tTTe6jXic0+Vs2Dk6kibYTczuRaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8116
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_04,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405270124
X-Proofpoint-GUID: dU0PPy2svgQGMxDb6dPSPrUbg59v8QXH
X-Proofpoint-ORIG-GUID: dU0PPy2svgQGMxDb6dPSPrUbg59v8QXH

* JaeJoon Jung <rgbi3307@gmail.com> [240524 21:02]:
> From: Jung-JaeJoon <rgbi3307@gmail.com>
> 

Thank you for your cleanup patch.

I have added two more mailing lists to the Cc.  Please Cc them on any
other patches related to the maple tree and mm area.

> Since there is no place to use the return value of the mas_wr_store_entry() function,
> it is correct to modify it to void.

This comment isn't clear.

Maybe something like (please, modify it to your liking):
"Since the return value of mas_wr_store_entry() is not used, the return
type can be changed to void"

> 
> Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
> ---
>  lib/maple_tree.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 2d7d27e6ae3c..da30977aab0f 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4203,31 +4203,28 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
>   *
>   * Return: The contents that was stored at the index.
>   */
> -static inline void *mas_wr_store_entry(struct ma_wr_state *wr_mas)
> +static inline void mas_wr_store_entry(struct ma_wr_state *wr_mas)
>  {
>  	struct ma_state *mas = wr_mas->mas;
>  
>  	wr_mas->content = mas_start(mas);
>  	if (mas_is_none(mas) || mas_is_ptr(mas)) {
>  		mas_store_root(mas, wr_mas->entry);
> -		return wr_mas->content;
> +		return;
>  	}
>  
>  	if (unlikely(!mas_wr_walk(wr_mas))) {
>  		mas_wr_spanning_store(wr_mas);
> -		return wr_mas->content;
> +		return;
>  	}
>  
>  	/* At this point, we are at the leaf node that needs to be altered. */
>  	mas_wr_end_piv(wr_mas);
>  	/* New root for a single pointer */
> -	if (unlikely(!mas->index && mas->last == ULONG_MAX)) {
> +	if (unlikely(!mas->index && mas->last == ULONG_MAX))
>  		mas_new_root(mas, wr_mas->entry);
> -		return wr_mas->content;

Please keep this return statement, as you did above, for consistency and
code clarity.

> -	}
> -
> -	mas_wr_modify(wr_mas);
> -	return wr_mas->content;
> +        else
> +	        mas_wr_modify(wr_mas);
>  }
>  
>  /**
> -- 
> 2.17.1
> 

