Return-Path: <linux-kernel+bounces-363043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2727599BD41
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 03:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2A10281D8C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 01:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D941C2C9;
	Mon, 14 Oct 2024 01:23:16 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474534A24
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728868996; cv=none; b=XNei9MJKfMTZ2/NzgzSnfZo9A2dzQTKU4F1fYjrNUPdBmlWdPoHH46WhxOa54mu4SRqFdFIvorNEgss4tZaFuZ7Nl+TVreVAsoCqmGZXScE7kFXPzsKLCLRxW8BV4qbGWS711t4wOqoGmVSNrDp0tB/T+QqvHbGc0XMwxN2gceE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728868996; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Message-ID:Date:MIME-Version:To:From:Content-Type; b=NqcIP2CmIvY2vqBUGFWd1FqkKHtHpn9MkZVmLokmJZ0py2b92MNzkCei59cU3XxsTKWlw0SPPPUAmTsL0OPlRmNPLrA0OEOEf+d1hET3nk+xgZwAEN+tGb+Jgg9U2Cz/Aw4X/x7EAVDmUcEE1frOoYvgPBQN9SpfQxrUsgxgPIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XRfb640k1z1j9nm
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:21:54 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C3C71A0188
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:23:05 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 14 Oct 2024 09:23:05 +0800
Message-ID: <4a698a82-61d7-63c4-3a79-19af29dcf978@huawei.com>
Date: Mon, 14 Oct 2024 09:23:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
To: <linux-kernel@vger.kernel.org>
Content-Language: en-US
From: Jinjie Ruan <ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)


