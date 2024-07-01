Return-Path: <linux-kernel+bounces-236421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D7C91E1FE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F157A1C21E2B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E78160873;
	Mon,  1 Jul 2024 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="S2Sbx9yq"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADAD1607A1
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 14:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843181; cv=none; b=iU3GBVKJNZKjLYgmGiOoQGkZWntu+K0ZS0D+5ORxqOC9l5bHt2/EEEJ0+2UVC3214tCDXvnqINTwvJKpzlegakxf4KcUGgRbnFKSF6s24It5Y8F02cP68ZBH1cdMtDZlZvs2uK1WUK2ULu2O5Vvhgv5oci5u+dzQfYMltGaI3hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843181; c=relaxed/simple;
	bh=bnKzxCczxj7exE8zB3Uv3Fdq7LNTmO4GPM0RE0oInPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Olauv1TyjX63voMq11CdhJFuhpMMvqgVkSeXEUIklK9f4dxYT+asarkrgckpJibS2J+EKFHUZVltHAlRwxxY+JMDiNJN2C5o9YFcpvKiU8nH3dj02oALOWwtS7MFlDcRVYb0e1NXKy5wpiiC+MLtvffCeZx5pLyvTcdtERn5TtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=S2Sbx9yq; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b598cd61ebso14867446d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 07:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719843179; x=1720447979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JKnbfg1hlhWUhZPl9//0SlqEeBxoNNmTMUDmPxznvko=;
        b=S2Sbx9yqn83j5s63fGsWLcx2j/4UmYAwna5GqppxE7igql0hUwe/7gu7TL+mMQSZs+
         2tk+vJRGDEgWVo0SijTDmreeI4LxUEk23AuM2/3VVMiKt7M2VO/SoRWsd4iCQdvHVAuj
         FFZ8XLOs1d/7GtJYeD20kcOUPXxXBzYmqa5CkP2FVeKXM+edg6bEe7H7ZrAvn2ttieQ4
         YvRRghawRkCcDihT9jnZi6arvDHlUoIFHIffF2sdmDWDLkcMDA5MQMzKyomirrSDCwpY
         hhAn/96HqJKjC2zgsqmgQFc1QtnvM2K3HNcNdOJQmUWG+MfLe3psGrnFufu3ja4xJrQ8
         4+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719843179; x=1720447979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKnbfg1hlhWUhZPl9//0SlqEeBxoNNmTMUDmPxznvko=;
        b=fzUBP2ezzqzxOI2napoLUHxqv2kosksxBnT0I0G2DvyteOXAurVg+Ve/LKjyBMQT1L
         xYwdrct5EPbzD+39kanuwX5JNqCmeT+UvAssSX9mVKXMA+WE6R6tiBvqvOWxKLxsmyal
         zmh97gUWxNf7Ct5yx2kWYN/MdvYOlmp6p7NMBIuL2Z5yDpt98nSwab0SF34d5/i0FjhV
         NVQWPZ+N8Qf4R9+TyvPTsfCc37YOOk/DrefRPQKOL/PWcMsIk3+Djd551daRBTtm7lA2
         kb70RL8W/pKytKqtImLSWdbKZiqAJBzCdqoYGw15pY1Dwwkgf12CopDFvtb3xbxCiDUJ
         Efrg==
X-Forwarded-Encrypted: i=1; AJvYcCU0IzeXll0A7fHwtPr9PNRNnBy8uKWuRkF1dWAlSVw1xBAGhQFQbGyY9K8EgYC4o4Kn8mqFxu9NGF+V2RtcMPZKh7l5LIMNIvbnH4Tp
X-Gm-Message-State: AOJu0YxmsGCwARkI2ArmaSJdu5RcmqIDY0vtFwruBIGyFmr50WK198of
	ENr82/pFHnn8HHNAjEuOdUYksESMn1wPhDK5FA4k9GMAO4Ix3tvKeREm+S7W7p4=
X-Google-Smtp-Source: AGHT+IH11J7tX3kn9wKKxcEVHDWj/dtG7QoadkG1tk+NAQPDcrgA1ZoxBt3iMiZT7AcpVkdIw1ARdg==
X-Received: by 2002:a05:6214:dc1:b0:6b2:b11b:c326 with SMTP id 6a1803df08f44-6b5b716a36amr73146456d6.48.1719843179438;
        Mon, 01 Jul 2024 07:12:59 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e368b36sm33551376d6.13.2024.07.01.07.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 07:12:59 -0700 (PDT)
Date: Mon, 1 Jul 2024 10:12:58 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v3 5/5] btrfs: rst: don't print tree dump in case lookup
 fails
Message-ID: <20240701141258.GH504479@perftesting>
References: <20240701-b4-rst-updates-v3-0-e0437e1e04a6@kernel.org>
 <20240701-b4-rst-updates-v3-5-e0437e1e04a6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701-b4-rst-updates-v3-5-e0437e1e04a6@kernel.org>

On Mon, Jul 01, 2024 at 12:25:19PM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Don't print tree dump in case a raid-stripe-tree lookup fails.
> 
> Dumping the stripe tree in case of a lookup failure was originally
> intended to be a debug feature, but it turned out to be a problem, in case
> of i.e. readahead.
> 

I have no objection to the change but I'm curious how readahead triggered this?
Is there a problem here, or is it just when there is a problem readahead makes
it particularly noisy?  Thanks,

Josef

