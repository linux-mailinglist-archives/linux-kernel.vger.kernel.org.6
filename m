Return-Path: <linux-kernel+bounces-265126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E61CA93ED0B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2863D1C217A0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 05:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EB4824BC;
	Mon, 29 Jul 2024 05:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0JUv+ZS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C35F817
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 05:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722232087; cv=none; b=LpYalo4iccV9Yei1QMROZ/aHWsird6uKOu5xwuWjMFDRLgBTnF/AteHf6YJRsVbWPSGjYdSSq2/bRdY++HCF9Lbn7ySD+67oTf8pQzqVgZT94ihvAy5Nz03KkNRCmDD9EDP8GWHbiZwY83qguMgeByejB82BYWa6Cjonn2Vp34Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722232087; c=relaxed/simple;
	bh=I5M/VKzv7JcQJ9QYxoOhUqZPN35VLPEFIB3A7TnDfiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F0wzP/PfTgYVQvK9+J0X7+8zpW1rFUvvDiHXFT66dHVcJdilRMoP6p2I4K9h/x47cQhyQztYxnkpDdz0ujAhnvEvBr9j4uQwHiWA6mKdwG1L3qv069Hm67u90aBRhvtMdK3X3QWPCrBBGfv5Z6S+F2G7zjHBbgAZpsfenRht1PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0JUv+ZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF06C32786;
	Mon, 29 Jul 2024 05:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722232087;
	bh=I5M/VKzv7JcQJ9QYxoOhUqZPN35VLPEFIB3A7TnDfiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l0JUv+ZSuNCu8YICJPMSWRKEvdIckfagh7pXxZPVaowZf1NQ5DxkYAKocf0fqlFlW
	 ExOIfd11MP4G4Vm6saiPzF69IceusOorWdtbmI/MV3uD9ilXwmasJAKfHRUVnSqrW5
	 pIA7F5EG7nA+1+umoWx9RX58UcwAiqZAU3ipohFHYC41WWzAa0Q7p1q8Ho2JvtvrV7
	 tbHoYoyPjl9KtzGjA0TleO+p7IvjxD8nk8TJsIix116HT8+9PkppIdbW7/THMmSDSD
	 f14Sk6H1D8rZcoHWhSaFyWtV1998XtBsa7AlPARRrxfwuZ3TO6WQPdMcR/xIiNcvDf
	 w9T2Eu8j+h2vg==
From: Mike Rapoport <rppt@kernel.org>
To: willy@infradead.org,
	Liam.Howlett@oracle.com,
	will@kernel.org,
	broonie@kernel.org,
	akpm@linux-foundation.org,
	Wei Yang <richard.weiyang@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/3] memblock tests: include memory_hotplug.h in mmzone.h as kernel dose
Date: Mon, 29 Jul 2024 08:47:43 +0300
Message-ID: <172223199651.4091981.6640447597186946592.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240712035138.24674-1-richard.weiyang@gmail.com>
References: <20240712035138.24674-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 12 Jul 2024 03:51:36 +0000, Wei Yang wrote:
> In kernel code, memory_hotplug.h is included in mmzone.h instead of in
> init.h. Let's sync with kernel.
> 
> This is a preparation for move init.h in common include directory.
> 
> 

Applied to for-next branch of memblock.git tree, thanks!

[1/3] memblock tests: include memory_hotplug.h in mmzone.h as kernel dose
      commit: b6087e14abae4cef271e563d9e15df3a872c3646
[2/3] memblock tests: include export.h in linkage.h as kernel dose
      commit: 5e45c26c128e59edf97f81434ea0364763da2a11
[3/3] tools/testing: abstract two init.h into common include directory
      commit: f56de22145544aa1e6c922c8f3b37157c820c8e3

tree: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock
branch: for-next

--
Sincerely yours,
Mike.


