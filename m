Return-Path: <linux-kernel+bounces-274691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD6A947B7A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08D051C211DD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF9B1591EA;
	Mon,  5 Aug 2024 13:01:00 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED8E1E480
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 13:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862860; cv=none; b=TMP3Da7TemUz0mPq3/U3KJ5gKOFINnFSoq3UYjdVzsE/FOa7y7ErzDmaoRK+IAX91kOmr/o58k3tz6kzT5paeXTc5//9tBT0qE4QGGao79OgQ6sQuY7+e4u5qnz+FwGi9DRetOYPCLN69hY0pBiHBdZVjxdQX0+ZHg+u3cg/fJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862860; c=relaxed/simple;
	bh=rJ62KkOnN6MRE6wHqKVY+BK52PEXH/cJY4i1COsZpA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKKBtnRVt9sFbMC8Icav3WRoFVAlTiicV1R2a7mhvhiboPLpUEDh2P2tdQ8NcvTies5lR/5nmig9VCM+xU4GgIJ/hQX9U1k2qi98zA2RJXPe0QMaDzELQhyihGgvyqcNytZhEXa2Qlk73nq9e8GHSkRq8X23X4mhz/MW2Q2Zz/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5a10bb7bcd0so15167157a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 06:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722862857; x=1723467657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhzYmsesFgjPOxLJHCKXw1dEAKNFL5PGI7d52gEVYQ4=;
        b=vCNydbuqBPRz/XZhwD45lOI4VBWkxNHURL3IDtMAy1SSCVa3wTOnpKYUycqBdEmDAh
         SC0BBWpzb9w2wG/4C+HgCjNob2KN99dbYgeUAGEXYklFdAEclfGM/7EsCiMB6M/nzdBR
         XfQs4H/CU1kq6B+I9Z+oHuR1cuQUfDa8XDf34oORpxqmM9Lu3edgAiysHiPY09DkjDZe
         9IuYu/Gsy4qfFKfJ5DYrMW+fQhFJliwF+8GKHdAIn23JS9uyPfmE5Yjx5IFdDAmYWOdF
         Uw4BIskF6/vVQO19GEgzK4F6TW1Hqan3yPoXAUWJDMCMgUZcNahSsRrKvUjC1rRVNpnD
         u/+w==
X-Gm-Message-State: AOJu0Yy5945twYyzBy2NqiJhFyCYK78z6w/ShWPL+P6zM0OksMTdEBkn
	/BdcV0Xizq44d6cTcYV8rpfdCudOW/V8FOnAherr0ENHE5eYDNx1S8e4rQ==
X-Google-Smtp-Source: AGHT+IGnFKkX8FyCq+vvbxVrOKXyoc7RxEuKvyTv2sZstr/UnsRW4qTFyIkh4r/bJ8LXE3iaYKPkSA==
X-Received: by 2002:a17:907:7f8d:b0:a72:5598:f03d with SMTP id a640c23a62f3a-a7dc5157d5bmr855299366b.59.1722862856653;
        Mon, 05 Aug 2024 06:00:56 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e80e5fsm449101266b.161.2024.08.05.06.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 06:00:56 -0700 (PDT)
Date: Mon, 5 Aug 2024 06:00:54 -0700
From: Breno Leitao <leitao@debian.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org
Subject: Re: [patch 00/15] x86/ioapic: Robustness fix and cleanup
Message-ID: <ZrDNBiUhGIKaq9ng@gmail.com>
References: <20240802155038.556977544@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802155038.556977544@linutronix.de>

On Fri, Aug 02, 2024 at 06:15:33PM +0200, Thomas Gleixner wrote:
> Breno reported a panic during testing with failslab in the IO-APIC
> code. This is a historical leftover and can be handled gracefully.
> 
> While looking at that I stumbled over quite some historical leftovers of
> debug printks, overly big comments for trivialities and a pile of coding
> style violations.
> 
> So after fixing the failslab problem I just went through and modernized the
> (IO)APIC code.
> 
> The series is also available from git:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/apic

I've tested these patches on top of linux-next tree (3608d6aca5e7 (" 
Merge branch 'dsa-en7581' into main")) and I do see panics anymore.

Tested-by: Breno Leitao <leitao@debian.org>

