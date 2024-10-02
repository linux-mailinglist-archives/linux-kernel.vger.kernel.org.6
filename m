Return-Path: <linux-kernel+bounces-347173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8486F98CF0A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0B092857F9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 08:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE62197A69;
	Wed,  2 Oct 2024 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ace/cMNQ"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC91119645D
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 08:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727858492; cv=none; b=EL8wjqgqbkxxvZWw01KqLwjfpEv+Bt9vK9cRrhwdZ+af0MKF3HRFeoc2165dlGRmhPbosMDl89i+baGQSIdoqlnYuRPVXEUJ026yk8RadWkl3pQH3Ur+Yo8a3fyRO7yw0Ll7RLGedQYxLiUlC5IgkhK6LZi8Nrr/7EE2pbX4zSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727858492; c=relaxed/simple;
	bh=dL7p2JI+1P8mlr+UA9s4fuBalO3A+oVP0kigovPZ3+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPtjeaaD+jatjfhwWW71GICSPgqf3FkC7ilHXay6AATcf7hSdB+nU925vkML5hhVO5AGI8BwN0mNWW3dxKnllHekADn+FFxpdEvy/Gu39GcjFGe7PbpjnrFngag8/JAPcD/onRjJBALCcF2Nwb+pNQceEpbjqwRjqmGDr6QqFmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ace/cMNQ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=3C0G3O7yUy9ur5Y6JDJ87KZIBLP16PDJXXsStwR47lY=; b=Ace/cMNQVe0c6T9oh88YX/IbtV
	+ZPCwpY+9Dp83bSb2xRbhQsuaMeqT2rU0tfldxjT5TLhU5aMDOPEY+wYiU7cECRAYX7l0ZhA4SBgr
	dPSPm7OiA+My0hhscawIG5hgyMpSJDV+fu4LVSCqtx5DpQyEN5Zd9/QOxgPY8TiosQeMlVD5tKEkn
	38tR8qjvqM8r/vfBnha1BEfa+W/wkLIppXE29TT82bByfRPuWBMszxSRYohCLSDC83di0v/VPNbuh
	UVPnFzf8RL9Yb+t9rdsbeAxwLx2MR4dhYbTCTLFhFop7a7S5C8uMq2x996aO0zijG2Z7onXRKQghC
	eZG+38qw==;
Received: from fpd2fa7e2a.ap.nuro.jp ([210.250.126.42] helo=[192.168.1.8])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1svuvB-00000003RxD-06Jx;
	Wed, 02 Oct 2024 08:41:21 +0000
Message-ID: <afd78995-df29-45e8-8856-7645bd75cb6a@infradead.org>
Date: Wed, 2 Oct 2024 17:41:13 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ps3: Correct some typos in comments
To: Shen Lichuan <shenlichuan@vivo.com>, mpe@ellerman.id.au
Cc: npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org,
 maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
References: <20240930023234.7457-1-shenlichuan@vivo.com>
Content-Language: en-US
From: Geoff Levand <geoff@infradead.org>
In-Reply-To: <20240930023234.7457-1-shenlichuan@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/30/24 11:32, Shen Lichuan wrote:
> Fixed some confusing typos that were currently identified with codespell,
> the details are as follows:
> 
> -in the code comments:
> drivers/ps3/ps3-lpm.c:94: rigths ==> rights
> drivers/ps3/ps3-sys-manager.c:365: acnowledge ==> acknowledge
> drivers/ps3/ps3-vuart.c:470: remaning ==> remaining
> drivers/ps3/ps3-vuart.c:471: transmision ==> transmission
> drivers/ps3/sys-manager-core.c:15: Staticly ==> Statically
> 
> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>

Looks good. Thanks for your fixes.

Acked-by: Geoff Levand <geoff@infradead.org>

