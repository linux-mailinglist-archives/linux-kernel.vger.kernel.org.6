Return-Path: <linux-kernel+bounces-173346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4772C8BFF27
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1E811F27D80
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A6D129E9E;
	Wed,  8 May 2024 13:42:04 +0000 (UTC)
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CA0127E04
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 13:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175724; cv=none; b=hvtxNje5RnYkkzZoRK+ATEaaKjt4x1Nd+VszXoI1OSgdM8GfkD2rS1tdWZxIxzCyKJ7d0VLFwzPu6N165g4HfYTXZRcFi7+elSoTlHmNvcL6a34tqDOXkCT2jDQd2B6mqJ4gOic2Y9Ot4QbmpttX6mgRFdVGcyFeXaPvYZk/jmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175724; c=relaxed/simple;
	bh=v9QEI2swd4ibYRQib9X2qTXan9Bsav/HxOk3ccbKowQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=s0oY8SBojX/1EIyK7Wp7cxojKyZ8PS2c2mmZaKHyTHEOmqDZjoTZVlLqrVYI86RGj0LDsECPtBDjc0dtHog8ND3X+28CTiO0ERJzm0D+4LpZvh7nThU1zTFsNkRmF0r35nXlYxI0LcKQXj/4RvwMjO+YkAylYkLP0vyb1g1Ahtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VZGXV1jqyz4xMw;
	Wed,  8 May 2024 23:42:02 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: rdunlap@infradead.org, arnd@arndb.de, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com, Yang Li <yang.lee@linux.alibaba.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240408083916.123369-1-yang.lee@linux.alibaba.com>
References: <20240408083916.123369-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next 1/3 v2] powerpc: boot: Fix kernel-doc param for partial_decompress
Message-Id: <171517558552.165093.6279419797489476438.b4-ty@ellerman.id.au>
Date: Wed, 08 May 2024 23:39:45 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, 08 Apr 2024 16:39:16 +0800, Yang Li wrote:
> Fix the kernel-doc annotation for the 'skip' parameter in the
> partial_decompress() function by adding a missing underscore and colon.
> 
> 

Applied to powerpc/next.

[1/3] powerpc: boot: Fix kernel-doc param for partial_decompress
      https://git.kernel.org/powerpc/c/6efc2f1a64ef62f1e3893da90d6ac618988992c2

cheers

