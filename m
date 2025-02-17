Return-Path: <linux-kernel+bounces-517588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBB7A382BF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33F5116DBEB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A782217723;
	Mon, 17 Feb 2025 12:15:49 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7514217646
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 12:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739794548; cv=none; b=qrGdGVCsUBB3p83JJaKMd1ATFKXEdUNE6y9ergb7QpELnpPSHPLXy5D+Qg69RcH/HmNP+BFmdIl729NTQcyKc/U8jsBV8jt5/qhFy/gODQx22hEb4/jc8pLbrz9sWaTs0bIbT4QcCKyJlEej104QqDRRSw+0G9MeAw3eYqb5Z/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739794548; c=relaxed/simple;
	bh=5TjgkkSINWgJEQIi2isuyxv1J/vec7nF7rZ8KOf//Ko=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sC9dwnunNtTKCGtW+Hmx53Rq8LjxXTMIOfxFf7drNwY73u2Z/1vtWssW9OqGayCMDGql1oEHKavxoiCJ5l2RHJIiVoLCSXw7qLjh77hH2LYx6p+Vy8axbmmXjVWVsBSF+L5nD9uaaKtoltS3DQ2/22jVta85LD8bPik/L8/R5vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4YxM7x0bsWz1xxQk;
	Mon, 17 Feb 2025 20:16:13 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 8C05C1A016C;
	Mon, 17 Feb 2025 20:15:42 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemh100016.china.huawei.com
 (7.202.181.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 17 Feb
 2025 20:15:41 +0800
From: Kaixiong Yu <yukaixiong@huawei.com>
To: <pengfei.xu@intel.com>, <yukaixiong@huawei.com>
CC: <brauner@kernel.org>, <dave@stgolabs.net>, <david@redhat.com>,
	<heng.su@intel.com>, <keescook@chromium.org>, <linux-kernel@vger.kernel.org>,
	<lkp@intel.com>, <mcgrof@kernel.org>, <willy@infradead.org>
Subject: Re: [Syzkaller & bisect] There is WARNING in shmem_writepage in v6.7
Date: Mon, 17 Feb 2025 20:09:55 +0800
Message-ID: <20250217120955.2110784-1-yukaixiong@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZZ9PShXjKJkVelNm@xpf.sh.intel.com>
References: <ZZ9PShXjKJkVelNm@xpf.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh100016.china.huawei.com (7.202.181.102)

Kindly ping!
I also find the same problem!
























