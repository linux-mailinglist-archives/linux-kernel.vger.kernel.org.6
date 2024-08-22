Return-Path: <linux-kernel+bounces-296921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADED295B0A2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E8D3284E76
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9EE17085A;
	Thu, 22 Aug 2024 08:35:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D79A926
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 08:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724315711; cv=none; b=A9chvPzmx8WtEHEsJDxpjWNqE7NXpDNi5hahjIEzVXcrSRwRPXvJCqcr27wAAN37ohuJK+cUsAFAhrIVD20fdvChRiKK1A/G25/VEyJrRwrCvd+4hARbI1lqIfkP1VpQ433v4MN8BiOLFhTI0VJYzApsERPuNxiyA+LZGfR7Sbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724315711; c=relaxed/simple;
	bh=cjl36kzHBjuOryBg4s5q+PNjoIbXlnacYInWNBE0d5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nT1lv5yNp/8qT78wnAs1Onuv4/1KqWcm9dWRJTWtw4XVT7FDeT7vllW8S7ucZCU+GddqLvNbM60PmwBz+1EkMZwEnP/Av499sadp9xMb2sQJee9zgrsv3wXiqaG4/va3tOXtYikxcY6TzlNS8IXmPFsbcRzjpsMozrF2jbXNXcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9597FC4AF09;
	Thu, 22 Aug 2024 08:35:10 +0000 (UTC)
Date: Thu, 22 Aug 2024 09:35:08 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/2] err.h: Add ERR_PTR_PCPU(), PTR_ERR_PCPU() and
 IS_ERR_PCPU() macros
Message-ID: <Zsb4PAOjlOeD1l6K@arm.com>
References: <20240818210235.33481-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240818210235.33481-1-ubizjak@gmail.com>

On Sun, Aug 18, 2024 at 11:01:51PM +0200, Uros Bizjak wrote:
> Add ERR_PTR_PCPU(), PTR_ERR_PCPU() and IS_ERR_PCPU() macros that
> operate on pointers in the percpu address space.
> 
> These macros remove the need for (__force void *) function
> argument casts (to avoid sparse -Wcast-from-as warnings).
> 
> The patch will also avoid future build errors due to pointer address
> space mismatch with enabled strict percpu address space checks.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

