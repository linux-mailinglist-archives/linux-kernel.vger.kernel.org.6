Return-Path: <linux-kernel+bounces-275628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 982B89487BB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE8641C221E4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA0D3C485;
	Tue,  6 Aug 2024 02:58:51 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3BB63CB;
	Tue,  6 Aug 2024 02:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722913131; cv=none; b=KIp0z6I11fDOX/rzJWKK10No+bxogPf6QYbwqnHppK6WiFRBTnl9E8KsDN9Nw5r++QywHV0k0uuqSiiZatSW7ySeIGY17mEqp6FNmig/mYkKHlFrLPjdC9hWcquJmlaAEHrJvJpzkdGmAjFYOn4Mo27lezC+oiYWaPlJ6QPHVjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722913131; c=relaxed/simple;
	bh=o2XfcUehCxk+xpg4apJIWodfANEaF3QPmJHEJrzeOEk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CNlXPZbjq3voN1XVJqYGDBwoBcs8vOMR6VXFyb3R2xMSQuTTr/TWgWRsF7RiuUSjjAhyp7SUELRk9fAdRKJcah0bdrnmW2YX+GppQhXpAcMTaUAu+H3kff2OCnb9quQavsBJmHgiXO613RkLiiqHc204bZVpYDaDY3/v5Hh06EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WdHvH4fP9z1S766;
	Tue,  6 Aug 2024 10:54:03 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
	by mail.maildlp.com (Postfix) with ESMTPS id 313B514035E;
	Tue,  6 Aug 2024 10:58:45 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemd200012.china.huawei.com
 (7.221.188.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 6 Aug
 2024 10:58:44 +0800
From: Wang Wensheng <wangwensheng4@huawei.com>
To: <lee@kernel.org>
CC: <cve@kernel.org>, <linux-cve-announce@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <xuqiang36@huawei.com>
Subject: CVE-2024-41008: May I get more infomation about this issue
Date: Tue, 6 Aug 2024 10:46:11 +0800
Message-ID: <20240806024611.130463-1-wangwensheng4@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240716080357.2696435-2-lee@kernel.org>
References: <20240716080357.2696435-2-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200012.china.huawei.com (7.221.188.145)

It looks like a feature from the commit message of the fix patch.
And I have search through the internet and get nothing about what
issue this patch fixed. Could you give more infomation?

Thanks.

