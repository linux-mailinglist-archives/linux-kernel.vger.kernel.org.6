Return-Path: <linux-kernel+bounces-310810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5805296817C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC2A1F23463
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E328460;
	Mon,  2 Sep 2024 08:15:49 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C5514D702;
	Mon,  2 Sep 2024 08:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725264949; cv=none; b=fezm3PK93L7/KsmBUk+gaS6X4fsEvgKIFReq6zaS8nzt7jU3mLcAzlL+0l3SEZthrVvQN7y6ezblK5c+8vTj+Ym+gfvPNfXftgJ6sUTA3OYNFBjRNVfbfkc33GEDQv1K4r52AKLrwNQyiDrULDqjVV6gbDU7RTcaJj2H17fjb/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725264949; c=relaxed/simple;
	bh=eRuhdcpvNMEE+QALMOZ3ZpIJp/HtHjvVouJYDJn1HMQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CphJoaRNFkM8sz/5dnqM7nV9tWk9oE64s8TjK2tb51kejuztS/93XBXQJZY5krfqbF/4nNvL5KgYY/00fS67sntGpDa2QxFCdTQ/R034KPqGdxsj7jvH65czZ5V5Da31ZueIeSY7xkYs39II7WnjuEAMRYDu6H+TVqYBt25ZRFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wy1js6MKMzpVHR;
	Mon,  2 Sep 2024 16:13:53 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 4E6FB1800FE;
	Mon,  2 Sep 2024 16:15:43 +0800 (CST)
Received: from mdc.huawei.com (10.175.112.208) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Sep 2024 16:15:42 +0800
From: Chen Jun <chenjun102@huawei.com>
To: <gregkh@linuxfoundation.org>
CC: <cve@kernel.org>, <linux-cve-announce@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Chen Jun <chenjun102@huawei.com>
Subject: Re: CVE-2024-43867: drm/nouveau: prime: fix refcount underflow
Date: Mon, 2 Sep 2024 16:01:14 +0800
Message-ID: <20240902080114.69287-1-chenjun102@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <2024082157-CVE-2024-43867-0620@gregkh>
References: <2024082157-CVE-2024-43867-0620@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf100008.china.huawei.com (7.185.36.138)

Hi,

This issue seems to be introduced by 019cbd4a4feb instead of ab9ccb96a6e6.
Could anyone help check again?

Thanks.

