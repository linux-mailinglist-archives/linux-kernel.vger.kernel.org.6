Return-Path: <linux-kernel+bounces-577039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0417AA71796
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 903C7174138
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21721E832F;
	Wed, 26 Mar 2025 13:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aoAcQMoR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BE31A4F12
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742996063; cv=none; b=nNMDOKHFposuACpC7CESGl662iuPu5TZtun6JjDa3nM+pCVDBfJIQ6vzwOQQ2GQ2P1fEgejMFHNAJYrAO/EDvPBE3Z/b/Hho3va5aYjM2BoGyRC61LqPieeaXkVjKlFzhLN48/lEK/EVwcNQ+khsFFptfO1qw4bCd7jcMGzhXYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742996063; c=relaxed/simple;
	bh=Bmi2Z+lEmXbRmpIdLDvclTMBagie0ZgkchdaLtNBubM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vB91dZZHlaRGIAqWgJ0eYtLzxmFoOXBzsPx/zpiRrJT/7OI3vabbrX76GPO60dbFAKmJ5RQEaA+GEmw1+cnjG77jT1OIihirgiS08RHwnmFSllFR5TvYn6V9jbmx0qNI7MIFmr5gvcvZb0Au12/my1yFV4gc0KPm6uhHLg1dPLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aoAcQMoR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735B0C4CEE8;
	Wed, 26 Mar 2025 13:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742996062;
	bh=Bmi2Z+lEmXbRmpIdLDvclTMBagie0ZgkchdaLtNBubM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aoAcQMoRKfcUBHH5MFoOFLhaecqQhxXWukc/2s497MQP6vIyuL6KRctIfdnxJV5kr
	 PesrpsWb1o7I7kmMCr/JYXqggYmfvLEfJwTsjTJiQpi+EPHGtyaq9WtKx/rLOK/sya
	 EbJMnnl6AIqHCZ7nWa0yJ1MTI4mthj8/q9EwR2is=
Date: Wed, 26 Mar 2025 09:34:21 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: linux-kernel@vger.kernel.org, helpdesk@kernel.org
Subject: Re: [Linus Git] nginx - 403 Forbidden
Message-ID: <20250326-fervent-tunneling-frog-c56394@meerkat>
References: <CA+icZUV6dLN3qBgzZFFq2gcG3Bssp6UShafLF-3A3BLpGAGt6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+icZUV6dLN3qBgzZFFq2gcG3Bssp6UShafLF-3A3BLpGAGt6g@mail.gmail.com>

On Wed, Mar 26, 2025 at 10:35:53AM +0100, Sedat Dilek wrote:
> Hi Konstantin,
> 
> I see several ERRORs when reading Linus Git online.

It's because we had to deal with AI bots again -- I had to block all browsers
matching a generic Android/Chrome signature. The restriction is lifted for
now.

-K

