Return-Path: <linux-kernel+bounces-442394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDED59EDC30
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 00:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F7AA2815FC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C95A1F4E3A;
	Wed, 11 Dec 2024 23:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z65yBnob"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA111F866A
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 23:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733960669; cv=none; b=ad26TqiJPoA/6bskAU3D1RrdmPzeYoC6JhxUkKc4W0zVOPepJZKISS16sDUru5BHoFU4irr4SOW3fur8vb0YpfaSKTNV6t0HdzD2Fui04JICwG6L2wYS3f6dlYib1TinwhXgiv9qrWuAftjYp9/muSKNfzZr+k2lAubAn8hZA0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733960669; c=relaxed/simple;
	bh=a+c5XHBHPHf5DcF1zINo9Js3AvIy7oQZobulSu3s2zk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ed72gRZQW6jjedgld/4GBW2rka0Ly/l64ZYboxKHCzxRMQaUQ+jEhAEXgZwQWu2/l/RcFyjhXSCISp8vZaWUXUfsKroum3xeVKzfuQKmEykpjRCnboP0hA2z6Rhemjd70HXLl0VeOarcxD7x4BxqE/WD0rfixogey+7K2XfgkD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z65yBnob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477BDC4CED7;
	Wed, 11 Dec 2024 23:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733960667;
	bh=a+c5XHBHPHf5DcF1zINo9Js3AvIy7oQZobulSu3s2zk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z65yBnob/u6CN8UyV2EK8+CgcawyhiaThMszDDbCrEmSkeZTcqa+TcPHbqP41DnIh
	 ZIyXIcwVM7TCAPGu1RaCrNXGc3EusWDgvzIqDYnTwUJlSnmOnE0sOZoG0KTDrwX43J
	 Aq7Db1BqIQM4BNzGRlOsRGevDb8LEdojGTuVIOkhVoYdg4wz9aSyZR9keB3Py3B7we
	 xGSapV3tmEiuhGB/GGgBmqqroNLbBdq0TBCo/MI85tvW5yAqA5B4/FvTzhtYr9Ud3D
	 MIt1M1uaxOWH272mZU+sd0i1nnooxBkMJa6j9uyFc9fCMRVosBa0WjSgN8nMQ16Ub7
	 UimcQzXxAPIsw==
From: Will Deacon <will@kernel.org>
To: linux-mm@kvack.org,
	Anshuman Khandual <anshuman.khandual@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64/Kconfig: Drop EXECMEM dependency from ARCH_WANTS_EXECMEM_LATE
Date: Wed, 11 Dec 2024 23:44:15 +0000
Message-Id: <173395344324.1068904.2330956532631016501.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241210043257.715822-1-anshuman.khandual@arm.com>
References: <20241210043257.715822-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 10 Dec 2024 10:02:57 +0530, Anshuman Khandual wrote:
> ARCH_WANTS_EXECMEM_LATE indicates subscribing platform's preference for
> EXECMEM late initialisation without creating a new dependency. Hence this
> just drops EXECMEM dependency while selecting ARCH_WANTS_EXECMEM_LATE.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/Kconfig: Drop EXECMEM dependency from ARCH_WANTS_EXECMEM_LATE
      https://git.kernel.org/arm64/c/9456a15947c1

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

