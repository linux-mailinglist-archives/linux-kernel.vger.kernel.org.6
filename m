Return-Path: <linux-kernel+bounces-318381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB5A96ECF2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA40D283C1D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 07:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8214115533B;
	Fri,  6 Sep 2024 07:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D4EsJoI3"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540FE14BF8F
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 07:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725609316; cv=none; b=HdzlsP+pYm1Ts1TqiwQJ4x1oN7IgAvP89rbEoPfv66bc3ybXSdTjW+6tkmn3/rxyMKIgVbEImyVPvoa9qZhvHT9SvFsSuyEwS5GKEsLIJkBRy0UckUgVgpyzjxysbGPhCgEVtuH7z87eBojSj9+zl0UfcS5FHpRlS1AkYarEAXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725609316; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q3+OJpkIz+tp9oEutIacbG5AdBDRxkX49Mequ0oIRpLTuNEmRapGhoSOFxxXUct3Q4bHNMK2WDT+a5RsUnP3U5m5bjporqbjoF3zBvXhwuf0OUXO6BD8XpATB/4WULyHDklpaLzC9t3iPT4laoYSCdM58EXodK3omHt1fUhR+Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=fail smtp.mailfrom=grimberg.me; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D4EsJoI3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=grimberg.me
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=D4EsJoI3k38j+6r2N7C9Uqarr0
	E9UhvLFYXVAqWb0JxLAGOrKAGls1Lh9GyHZkpeJByWDpgwYlUqcxtogZP2/MMBOBvLsuSWJFxNuho
	YHgRkGSGA8rHbX7IpX2ENxwjyROG1Gwa7YDnrdqrifX4ZiZyPoe3BHmm8SDRRwcWelu57+jOFLHl8
	lzCNYezRvhoEzNxV+GBRdjcfMm9YEInyJ8KQBmIGOkBSnKgzMOnE2U4BjyN9g5Ky97j+/p39yc2zk
	iVo4D8CNlHVPdZ3M4cYPzmmLDQSUVhrhorZAIyZXJ/fJzpKbaLHJ4m0l78CvmfEtGSz5XIzkcdxWi
	dNK6FxOw==;
Received: from 89-138-71-253.bb.netvision.net.il ([89.138.71.253] helo=[10.100.102.74])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1smToB-00000003b5J-2wnl;
	Fri, 06 Sep 2024 07:55:09 +0000
Message-ID: <e39bc8fc-3e20-4e3f-b906-1c63953ab76b@grimberg.me>
Date: Fri, 6 Sep 2024 10:55:06 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] nvme: Convert comma to semicolon
To: Shen Lichuan <shenlichuan@vivo.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com
References: <20240906065815.40300-1-shenlichuan@vivo.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240906065815.40300-1-shenlichuan@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

