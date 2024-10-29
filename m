Return-Path: <linux-kernel+bounces-387763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A6F9B55E3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EEDC1C20429
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 22:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C52420A5FF;
	Tue, 29 Oct 2024 22:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="beOOzhj2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A6fRb4/Z"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A79199FBB;
	Tue, 29 Oct 2024 22:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730241612; cv=fail; b=ruRbN7i3DK9QiJmTZpUWPCaVSgOridOUPDY3JkJ+Rq8TI40nx7Wbl7VBrMU5GJtmlctdrQT7F8weVqx+AYEzTwnPFd/of//9q1A6Dsk/dnrDRTGHDc+W+xFk/WHPgUSuyR08fKUqhH3M4Kky1vHJIoFINlBUWoM7FOFdexkwYYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730241612; c=relaxed/simple;
	bh=CRnX50eNGjvcJFg1140Q8I/QSTDO3VZkekfSt5RRDBY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iH52co9NbxXMNLEPNPaP5s8qKvjaJMT9PfcdLYUQVEmcLUmb4Yp0wizrzAotFsMmS5htsZQw3/6W6PZ1fp+RxkieO+6/R4YAlYYhkR8GFkjzHwQTMU24AQXrl4N7YBNJ3FTtoJkaxB4dtaZ+7hdct2FAY688TH9gIBc47ozqFG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=beOOzhj2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A6fRb4/Z; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TGfgaK004520;
	Tue, 29 Oct 2024 22:39:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=CdQK5k/RsnYBUG/7xGY95VDld4OcBqUS9EkC41QN3m4=; b=
	beOOzhj2ng3oQnM1yJBRHN2Fc2C7O/U5wLFM91ssKLeWORSeYVjuoVMAdT9SKfH8
	chrAGbGz7oJ615I00BrdxJ4hcEIIjJNGEoodbsWU1FuwuEvGqAXxovdCKZaP/8CJ
	fMQv/sR6BSFN+4OllJhMzTz+i1r61+wIk/QclZGtfIXks0afYlzmrBHl+djsAf1h
	wGYoySVY3NAhTmD3x8hVjj9f+gTRNNOluWzGg0uQUFWHLBVo3noGAHiRJu/W+M3o
	+bIGk2qiKYJkrxYEfvwjZj3bqyJsw84Gsu3mWzUCkzBU9y7EzXuKbrGtYG4bb3Ry
	TshQIzjqEe51qKN6XJHliA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdxpqyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 22:39:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TM6glZ011917;
	Tue, 29 Oct 2024 22:39:50 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnad7rkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 22:39:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKWaTi3mRyNMboj8Cr0qcUxy3QfS+SIIZvy/eupUv9A/f+musmemS8GhTyj7zoF8P0ju/9alDlvfkF6M+SH/B+EUa7oJvGQp2OjHU0LwzJv85WC+F26j5y1nhj/49O36Tf7cQFGx3KISTfVxXJ2rBS8f7hBUitjckd1TgIXYpEfCQmop+O5PCwn9cdh2X0Ig0pEL7j0/LMaPJtnDoUrYvYSudkWw/7wtwjQNjpnSfPrhiX2z3XnpJE1FXGHE39f5qipInq/QRPGRIQcMxi6G3QcC+aY8/+gTDrK5r+UP+QCrfet8FFl4ewB6eBBg9UWIAz6TBSCohbXV6q/nCfka2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdQK5k/RsnYBUG/7xGY95VDld4OcBqUS9EkC41QN3m4=;
 b=DMcsWOfixKR46UXQMSpkFnXpTN9i+Wdx5B3E1Z/+X+se6OqYOZN+Tl0NB6EpLsGu8rvcjfD2ybjAZobOT6eqA6Q8D8oLkGGSJ+Sutng3Xd1iwR85oSf6jiq7QducbjTXY5eYOmV3zM6OfteQ6lU2Vel+R5IQNe5LPyj29zGk1TzVhMdsonNoce+lLRTTpSm9RBVLPUURJ/ZF5d7UyfzCP6M6WdNkogJEYkRhKuF+SPbmosSB8Ql2zDjbbWO4oQgI5nuTc9W5q2NqqMk7VKsniB9wYfh1N2hKVhbYrH8ejRjxtOhufyjePjNE+oBzsgiNZhPlfNbqRdCZDrRzbQMDcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdQK5k/RsnYBUG/7xGY95VDld4OcBqUS9EkC41QN3m4=;
 b=A6fRb4/ZCUgZsEvrhfy/tshwQ3zT45rb/M3jr1lgmH4AMNRG6K0NrgFbbrSPYHTwtBSCGPdsWXNtsthAFwzXF2/P3QD0F06bs+8w5OoCNK2QnD/bcg28HOh7vjGNL5EOLJGhjAh4xNUuF/vyHLUM0bSaja6+bKTX53r+76i516w=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by SN7PR10MB7004.namprd10.prod.outlook.com (2603:10b6:806:328::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Tue, 29 Oct
 2024 22:39:48 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb%5]) with mapi id 15.20.8114.015; Tue, 29 Oct 2024
 22:39:48 +0000
Message-ID: <f8ad2538-28e1-444e-94ca-1ede6e74e848@oracle.com>
Date: Tue, 29 Oct 2024 17:39:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jfs: add a check to prevent array-index-out-of-bounds
To: Nihar Chaithanya <niharchaithanya@gmail.com>, shaggy@kernel.org
Cc: jfs-discussion@lists.sourceforge.net, skhan@linuxfoundation.org,
        linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+412dea214d8baa3f7483@syzkaller.appspotmail.com
References: <20241008202137.8577-1-niharchaithanya@gmail.com>
Content-Language: en-US
From: Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20241008202137.8577-1-niharchaithanya@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::25) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|SN7PR10MB7004:EE_
X-MS-Office365-Filtering-Correlation-Id: e9cb85fd-46f8-4326-b6fa-08dcf86a9821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2NSUDVIVForN3ZnQ3F6VzJRYlBYL0lxRWd3NnB5YWd2Y2hZUzcyNXVJMFFW?=
 =?utf-8?B?RXNkVFE0S2xpL1o1a2VrZit6T1ZYTGhSaTJPWkRtYW5sbTh1eWpFRkdZNE8x?=
 =?utf-8?B?dndmU2FGUEsrOW02V2dXbXZ3bEdDT2FISVBKUlZzdDVuZCsyem9TTGtoS1A4?=
 =?utf-8?B?SFg5NFU5T0N6QWkvYmlmMWJ3U29lMDlqRVpiS0lSZUFSUEdxMXRkdE1hdzdk?=
 =?utf-8?B?RXMrKzBaZi85MkRNRGdsQmxQUG85UGU0dUV1SXJTQ05WdCsycWRXRWRPbXJC?=
 =?utf-8?B?cnZmUURjeXpONE5ZMUlmOStERkhueStBQkZVT1h6akFRcFRoQWVZNk02M3ZL?=
 =?utf-8?B?cVNqNzhTVHV1b3BLYUtGbjZJVDdFdVh4ckJaVGVpbE0zbnk4NGJ2TEsyaElK?=
 =?utf-8?B?c2hkaXhQcVJ3YXNDb3VsWndMcFZzYWdRNlBQTWw5Mlc3YmdVYUNrcEd1bC9w?=
 =?utf-8?B?OWdtRWJyRWhHOVZSOFRqaWE5QUNpeWlQcnZwRmEwZndwS2F3YkZCMzdUQi9x?=
 =?utf-8?B?WGYvNkFvcHgvczkvT1BaMFgrRlg5U3hocWkwSzAvOVU4NFQxOXoyemFiaGZJ?=
 =?utf-8?B?d3VqZEJPeUVZSW5NYlBMcFhPL1Z4cGZTMXR5UjBhWjJLQUZMRWxmY1BLeVBv?=
 =?utf-8?B?YTN4d0xqWGpYT2hUbUhtVHlGY2V4NEprL2dsUFBxM2dSVElZNmtCVVU0ZWhF?=
 =?utf-8?B?WUVQV1FyUDllWjFwZU83aW9ENkhsanlQNTNRUFQxaHBqeDVUMzVvUXJ0QmdO?=
 =?utf-8?B?Vlh1TWpmbDE4SDhiZExEUzJzbXEzYllOMWxqV2tGUlB1RkpDSHRUNTZRTm9k?=
 =?utf-8?B?ZExMMUpPRDIrQWxSMURmVDlrWDY4bU5pallGT3FDMXljbC9yRWx5YlFSU21v?=
 =?utf-8?B?LzN2NE5BRmdUbzRiN0cwbCt3aDhZai93V1A0ZmtON2NsZGtKa0xCR3hlL00w?=
 =?utf-8?B?enNPcGxRczBHZjN2bzZqK0ZFanZnaldCb01BQXZyemdaUWJ5V2M5RzVHS2Zz?=
 =?utf-8?B?eXdxc01qMU1LZU50cElHZ2Q2OUg4eDQ4ZWc5N2ZOeTRoL051VlV4b09wSVFP?=
 =?utf-8?B?WTV2Q096b0FzdDBIaU4xdUgxdDM1WDcyQ0Q4WjhYL0NZNzQrNWpQTkpRSFF2?=
 =?utf-8?B?bmpWUmY1MW51Mm1XaXBRcVBGK01tSkdvanhwN2V2d2liQ0ZMc2JYbkt5T1Rv?=
 =?utf-8?B?Ly9GWmFZd2hYQUlMa2ZsMW9xWHZLZnRaZ0dZUnhCMnFNR2RJazBJWjQzV3BD?=
 =?utf-8?B?czZuSEk5ZlRIM3RqMWR5WlRuWUpsMUM0UTF1dmZqcUtkaXkyQlVqVDBIRk5s?=
 =?utf-8?B?cmdoSk1URm5ZaENkdStCZXNLMzhXMU9KNnRxbGpJdUFyVWhJdXVpNlZsSGdL?=
 =?utf-8?B?YmNDcWxBZlgzTFgyKzJTamVvS0UxWUdSS244dVAyeW92TXpmVVFqTjdzR0E3?=
 =?utf-8?B?MGVMaUY3Vi9EbFNtT1NBbGlQRDBoY2dSZlRqUXBWMjlKL05LUUtSNXZIWFhj?=
 =?utf-8?B?SnFib1FtWXM1MXY4S09GTlQwK0JsMmNRVjllMUZ0TU5uaERQTFpFZ0JCM3hy?=
 =?utf-8?B?ZW9OUnR2MlloMHdYUUJ3Y1FLcFdKR2YxSCtOc01FR3V1SjhCSDYvelBleDJt?=
 =?utf-8?B?bmt1Zzl5TWZtN0xCVDVjaEp5bGc5UVd0OWZtVGhJdUUwc2tMdEpmMDFiMXdK?=
 =?utf-8?Q?mkdlvj44AtazOHz7G3iU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFcrUTBZYll3OWhqVjM1WGpJOENRcnNVTTVCclM0alZsTG1xekRjdXdRaTM1?=
 =?utf-8?B?RW53MytxODg5ZHpRb3pnQXZBek16cGt1akFnaFhkYzVGcllSdldLc3NQcm4w?=
 =?utf-8?B?ZzczNzdEdytwemRkTng2bHU0bHI4cTlFNDJJeUtFSUZMTERwU2NWVS9qaGxo?=
 =?utf-8?B?bCtTMEFCS0dxam10Unp1a2hoWERGb2lEYXpIVWx1VEJJTUVTU0huejdPd0lD?=
 =?utf-8?B?QnpuM1h1U2hlVFZJQWRtZmEvTHIwNng1MGNHVmdRd3dUWlpkVk1GRkNuWWlL?=
 =?utf-8?B?MUo2RmVkelk1WkJmTEt1SEk4U1crdldIdFIvOUIyeVRMVVlhREgwRzRFUkVE?=
 =?utf-8?B?QzlsVjFQaURRUlhuMU1ObVZjcWNDZjJoWHZPN2JQWHBKRk5VY1FlenlmYVVo?=
 =?utf-8?B?dXdDNlI1SWNXUDlKZi9VcWorUldid1NYY2d5SVNGOFNKOEtRWGxmQVZWc2hL?=
 =?utf-8?B?RGQ5WngzL2szRHlMeGlFV3FNMk5Md0xiL3VPa05Qemo2QTBGVmswaUZGdHl4?=
 =?utf-8?B?WDNTbFNKZFkwVGdDZHFOYXZBSjBzdythYzgrNEhOaVNRZzhFUjk2WVc0OVRr?=
 =?utf-8?B?WnJiaFZ4YWxNaklhU29EckZQcUVXY3ZjV3pOMzZDWEpBNGd0RmJmdEdZY08x?=
 =?utf-8?B?bnlJaXI0bkNKdG9Pb3lhNUJ6c0t0QkNRN3lidlRLWnA3U1l3UmlnTDF2SllX?=
 =?utf-8?B?RGE1enpDbm8zblVZMDZScFUwc3dOd0dEWms5MXlBZlBtdlFOK3I3YnExVWFq?=
 =?utf-8?B?M1hZV3BhRHNoQjBYdnVwcGF3WWJpWkJkSGg0LzU2N3JUMXExczhxdmNWakF0?=
 =?utf-8?B?b3Z1OHZRcW53OGl2Y0JwR0x0ZW9WMExHVzZuRTg0TWJjamxWY3F5NGxvaDZi?=
 =?utf-8?B?d3RBUWNqQ3JRZ0hmWCtiZVlUSmJLTk5nNzBHcFFHNGZROXlmMUtVR0tTMThB?=
 =?utf-8?B?TVptOFh6S0R4eGVvSEs2NTJ2b0czeDRFdzcrZUx2TS8rcHFqd0xnZXlmdHpw?=
 =?utf-8?B?VElZcWdVMG1IWmN0S1lrMUVlK1RRM3c1ZHkzOFE1QnpSV21IU0phMzF4VTNR?=
 =?utf-8?B?eHNYSE13c0lCWmp4NzI1N2d4Z29KRGd5Rnh3Z29wSnowcmR1bHNJYkR2U04w?=
 =?utf-8?B?eXIwbnBOdUwvRFBFcEt1WEtML3lsbzVXUkxFSWFSb3A4Yy9XQWYyemJQWFc4?=
 =?utf-8?B?dnNXZVlDUE42Z1I3QUFIWU1Kai9qVmV1b0R2dHRtZ0I0QzRSdkh2NFQ5OWw1?=
 =?utf-8?B?cjM0V0tSQmFZa3FBV1BlaWt1NmQyMVpTa3VzMVppc0dOUVNVTXRodUtjVGZB?=
 =?utf-8?B?Ym5lVTR1YWF3M0d2MlRiZXFHbVRzbEE4QzFYcjRmUUdZVFUwUGtoSHljdVVB?=
 =?utf-8?B?cFBBT2hjdVFYVm9ENGdOMWRmUHpmeHZQN1hQZW1xV0dnQ1drV3R0VXBSRjRu?=
 =?utf-8?B?L2ZZS3gzcHo0Zm5RamZ2VXplVHJQRTRVMkplZmdOMjlZMmJDV29ISzd1SXYy?=
 =?utf-8?B?UDJVNmJORDdsZUsrakhaekRVRjNTWWFKUlNiQ1UvUTJMUldJZStubnpSVS9z?=
 =?utf-8?B?L25vTmFMUkFQZ0kzZHpacjZGNTN5Z3ZYTGJ2UEY0MEFmakVXWkdLS3BneHVa?=
 =?utf-8?B?Unl5WjN6QVlSSnJPUlJnMld3ZkZST004MkRtd3lHNURjQzNNTlFhNjgzL21v?=
 =?utf-8?B?c1gyWGxIRE8zRnhCUVBTeUZjMmxSVGJnS29HU2V0cnV2b0xJdFNVQ1JXekpx?=
 =?utf-8?B?YmFIdWU3WTNRaURpQVhBemdVTm9aeFFXVHVjSVlhNmwvSlAyL2o2RXA0Mzkz?=
 =?utf-8?B?UFZmejBqMG54NlRLaldrakxRM3BTcGdyVzE5cy9BbFU2RXlFbE5ZVWE0NEtS?=
 =?utf-8?B?dUxZYWVpdFVCZmxrL0w2ZWRvOUZTSmo2RHg2TWU1VFFJSDZtVWYxbUZtaC8z?=
 =?utf-8?B?bUpBNHB1K0ROVi9UZjJGY3pvdURZNzJEdW11Z1k2Y2F6dDF0VGt2NjIwcGdM?=
 =?utf-8?B?T1V0MWJBZHB1T1B1a3pES21MR0pFUEhlUW05RXNQdlh2Y1V0MkR2SHlCblRC?=
 =?utf-8?B?SnI5Z3hGYjRPMkZIVkdBaUsxSnRvNm1MdmlteFB4TzBRSDRyQW1RZTdtNTRB?=
 =?utf-8?B?UHZmNkpkWCtUMWlDOGFqN3VNMWo1N2NEZm5KZDUzSVZwc2NxanZoNm5ldUtr?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZrbFp0xGuGliqxkSRWGkuyBc7rhGxXIzJoOZrDywIsmlWMnNNh3d0lzQHCm7cXxkmF9cWlPYe0eOORty0WIf/jWDN8KF8B25w53xiUX3ZYpl+Ad9TId10EbbGkpJD8qXsakHz73cisiZUMAsdbFD1OhnKb60qE9pWFIzvZJfoB2jM2BwU6x7e42WuqlV11KdlryFAMM3m/IUAsyCuLUCVRg7w3ZpWy4HUm0ylfJLOojJfxWLLbe/hk6NNJSwpIIsOiL9UaU5LmHpbFvGTVwgPU4l9W3zkNP6BBBQtbQcEjqWOfE8cfwofxkQRYVzFiLbt59VU5FYRuiRw1fCyenXNN8p/DcaE9iX6K5sCq0MyLQfW2o/QcY/O/5jvsX/pLFIefm6TIqCk5g+L3QpntmrOz43BfVMX5ySGi90gHIEJNNYYZJIyt5/xvMmb3N3fg5haogtRYL7DVKcPCzDsU+tZ3VIHYWsXJhuvG9wXVSbjgM0qqyXplQsiVAMKVXpzoeYOkFIQz9CQolUS/xjUVoxrEd85WKMPZjlygtPVlQJiQDYPlyHi0b/u4rhk2ldHkWcgJKlMCG3e5rV0fqMOWjE6uotMvoDhdr7qaXEkHP3Wvk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9cb85fd-46f8-4326-b6fa-08dcf86a9821
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 22:39:48.3925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QtEUEWkiMJE2DX025ZQpPadDu4sdoujBme4YyeijeXqaObpGmE2dwXDrIKFfj9Dm9kUaO8fpAsAnYQN2wXEZkcjMFIFhUwiCiu02YJbL6Dw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7004
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_17,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290171
X-Proofpoint-GUID: 4phduJks_-My7iSLgN-wCpKB3MUCaS0H
X-Proofpoint-ORIG-GUID: 4phduJks_-My7iSLgN-wCpKB3MUCaS0H

On 10/8/24 3:21PM, Nihar Chaithanya wrote:
> When the value of lp is 1 at the end of the iteration in the for loop,
> lp is modified in the next iteration to a negative value.
> Add a check to prevent this condition.
> 
> Reported-by: syzbot+412dea214d8baa3f7483@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=412dea214d8baa3f7483
> Tested-by: syzbot+412dea214d8baa3f7483@syzkaller.appspotmail.com
> Signed-off-by: Nihar Chaithanya <niharchaithanya@gmail.com>
> ---
>   fs/jfs/jfs_dmap.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
> index 5713994328cb..3ebb2dfdd0b3 100644
> --- a/fs/jfs/jfs_dmap.c
> +++ b/fs/jfs/jfs_dmap.c
> @@ -2911,6 +2911,12 @@ static void dbAdjTree(dmtree_t *tp, int leafno, int newval, bool is_ctl)
>   		 */
>   		tp->dmt_stree[pp] = max;
>   
> +		/* check to prevent negative value of lp on the
> +		 * next iteration.
> +		 */
> +		if (lp == 1)
> +			break;
> +

I'm going to change this a little bit. I think it's a little cleaner to 
test lp for zero at the top of the loop.

>   		/* parent becomes leaf for next go-round.
>   		 */
>   		lp = pp;

That and rewording the commit message, I will apply this.

Thanks,
Shaggy


