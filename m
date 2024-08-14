Return-Path: <linux-kernel+bounces-286414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DBF951AA5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 016FE2823C1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CDA1AED57;
	Wed, 14 Aug 2024 12:15:20 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85871448FD
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 12:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723637719; cv=none; b=tWrytHMIrdn0kMW+YoQHWgNgcMXoCUB9FYLWLct1wQKR+2clMgwtI7Bw6xEMfvogfftkVvL+rk7w7+QpVEuUD1yoha8ABpehPxojWBE2HiDzrRXAG8QooUYkpaX0pTXDamjKX1uuxoBbK15z7sxSruX6yvfk2W5L4zPFyZzbh9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723637719; c=relaxed/simple;
	bh=Oy02gJNPZlusUa55dqAwpCZJ5mfgJ+hmH2IygKNxlVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FF4bPvJDzIP0skpeEPDZJqtEgw+HfMVLosqNvzIP2tvW6OHvsApLcyUof3DT8a471Uagpvs/QoflA8uAmyyR9Rgyz9D114YiFAIpq3Xi3elLzrEGfjRTBSDbhgL9pCLuE9ArQeT9NxeqybWvbKWQhSrauSA6b6yzFlWjiFlvFH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F6FC32786;
	Wed, 14 Aug 2024 12:15:18 +0000 (UTC)
Date: Wed, 14 Aug 2024 13:15:16 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] mm/kmemleak: Use IS_ERR_PCPU() for pointer in the
 percpu address space
Message-ID: <Zryf1Av5AthqIKDH@arm.com>
References: <20240813172543.38411-1-ubizjak@gmail.com>
 <20240813172543.38411-2-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813172543.38411-2-ubizjak@gmail.com>

On Tue, Aug 13, 2024 at 07:25:11PM +0200, Uros Bizjak wrote:
> Use IS_ERR_PCPU() instead of IS_ERR() for pointers in the percpu address
> space. The patch also fixes following sparse warnings:
> 
> kmemleak.c:1063:39: warning: cast removes address space '__percpu' of expression
> kmemleak.c:1138:37: warning: cast removes address space '__percpu' of expression
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

