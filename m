Return-Path: <linux-kernel+bounces-286413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2643951AA1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE98281AE9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2781AED29;
	Wed, 14 Aug 2024 12:15:08 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260541448FD
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723637708; cv=none; b=W0btk1G1rrda6tzLVOdZmvby7e7VgEmvu0GTg83BMrYMGqaoD/zFsMD4HGn9wI+eXwOdug14qHRuLqWMg85Bau9TjNbH/2/uee4/KAGlkc8w86DpUKfEd0K49WSXrbIxi7NTPJ+2fzDYEVOvbsCsVL8Z9uU/+J1/5Q+BDn+8PUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723637708; c=relaxed/simple;
	bh=mp5a58drZmBDdiPuuHFppdSKaExwVsggrUDss2WJiqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLTh7So8VhPP9X4m8pfMtr1RVN885vGDvBKhMorZEwoeY0I4nSru+OqNb7UGc2VrBoSxWUXJAL+P3O8W2IapNSqUsGNa37BDIDpdZz8OqxuNv5IlolObircA+X/mkiAKLifOcs2k04rMRFQ2qGs9OepkOsHVhtOnDtOablJJo8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F12C32786;
	Wed, 14 Aug 2024 12:15:06 +0000 (UTC)
Date: Wed, 14 Aug 2024 13:15:04 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] err.h: Add ERR_PTR_PCPU(), PTR_ERR_PCPU() and
 IS_ERR_PCPU() functions
Message-ID: <ZryfyGsvATiiKeAR@arm.com>
References: <20240813172543.38411-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813172543.38411-1-ubizjak@gmail.com>

On Tue, Aug 13, 2024 at 07:25:10PM +0200, Uros Bizjak wrote:
> Add ERR_PTR_PCPU(), PTR_ERR_PCPU() and IS_ERR_PCPU() functions that
> operate on pointers in the percpu address space.
> 
> These functions remove the need for (__force void *) function
> argument casts (to avoid sparse -Wcast-from-as warnings).
> 
> The patch will also avoid future build errors due to pointer address
> space mismatch with enabled strict percpu address space checks.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

