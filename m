Return-Path: <linux-kernel+bounces-298531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD45F95C874
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ADE1283508
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88D1149C68;
	Fri, 23 Aug 2024 08:54:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B09B1494D6;
	Fri, 23 Aug 2024 08:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724403258; cv=none; b=Z2akU6OWmxD7sNMHALNJTTiJkZAVcuih3BkhmwlZmYv1JgXwZMlD4GYhqzl0gekKcaIHOCpoJ2MwRkT0T/ep93W8nJ4/h1BygSEM7IRd3Er7GL2k67BcwGYUYvbxJZYE5nQPGEWyUP5m2hGKMa7ESCOOC8bjvn9SMLgJlKA52wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724403258; c=relaxed/simple;
	bh=7i6fCcCwJYX6XAHAEsm0q7UIi0qq58vGvrmMaBBTV08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSl7oxhXiDWK2Qihj/gSM1GdqiKNnk3JzXauT3S7RlVf8F+NMu2xLfAUo6YOAJx1U4SfjH6QbTiND/IzUQy9vBT3a9o9b6DLGpjCk/DH7alQx4I1xa0BvV9/ySkWLTa/YS1DIkNaCCAD3V8yOtvXJxJpzXrPyhTki1P6Wsd01TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DADAC32786;
	Fri, 23 Aug 2024 08:54:16 +0000 (UTC)
Date: Fri, 23 Aug 2024 09:54:14 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>,
	kvmarm@lists.linux.dev, Paolo Bonzini <pbonzini@redhat.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>
Subject: Re: [GIT PULL] KVM/arm64 fixes for 6.11, round #2
Message-ID: <ZshONupF3nIhAlRf@arm.com>
References: <Zsb4kbq6FAfgg4WA@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zsb4kbq6FAfgg4WA@linux.dev>

Hi Oliver,

On Thu, Aug 22, 2024 at 01:36:33AM -0700, Oliver Upton wrote:
> Paolo is on holiday for a few weeks and has asked that KVM arch maintainers
> send pulls through the architecture trees in his absence.
> 
> So lucky you, here's a pile of kvmarm crap from the past week.
> 
> Details can be found in the tag, but this is a set of small fixes
> around the shop thanks to syzkaller bringup on KVM/arm64 and a few
> recently introduced bugs.

Pulled into the arm64 for-next/fixes branch. I'll send a pull request to
Linus later today.

BTW, I'm also away next week. I'll randomly check emails but if you have
another pull request, better send it to Will.

Thanks.

-- 
Catalin

