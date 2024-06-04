Return-Path: <linux-kernel+bounces-201106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC77D8FB995
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A19D61F25E08
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357C51494CA;
	Tue,  4 Jun 2024 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="tgiQ44bJ"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6962148840
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717520003; cv=none; b=rDGSgKxRtO3mwPbGkUI5fpFsZH04pKO00lbm9/ET+vgIF+y+83InNvYdy2S7IBvCsNNEkEO4Po+jCJ5cok3Ox37vgNNOD8EDDlQ0XJlp3X+NoeN1WuGQSEiMLAvD70ZoN7QtpgbRQw7fF3zUmGf0lpDb6WTQk6eSn+SbF+89TWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717520003; c=relaxed/simple;
	bh=yBAgk7JYRJdSCs/1yDW6N2bILHhUa/I1Vjjoi64zjow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P62CzkBfvMQaNpbaU+yvjHpLMdFh3bF0n7l/3ueAPHhFs2XN2DSTi5fOYF69r6bFskaDsa47INzdDhk2Y3blEeWrg3x1rBK5jMrohG8cBtUmJE9L5bRcaKCwljFTGJME9UfYk8h0lie4ffhMkXeuyFpyBn2kNlLuadnnT23eu3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=tgiQ44bJ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c1b9152848so3992656a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 09:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1717520001; x=1718124801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7vQ85ddbl1Y3ttl8lJSOOTPnAC8qpNtaLzkY277e3vA=;
        b=tgiQ44bJ3xcSY56L4He/DRGJfOM9rWRrK+mBbyVI4ZmiR3VFZJK2ql+bP/t2p7Y3Ae
         pQm9JfcR/IB+yn9jo7QUMF/fbltRQ9AXooy4q5FYWujDwPtV/z6Kx2KezV/74dkDKFDH
         7tDdMyF03bXsrOVLJCF6ZvNJfgutuzVosA2wLk6aDYb9LNvn2qr2s0rKEO/zawtZmnkK
         AaZzWzacCnOPJMgXicIHvhhUW4Zzo9Z4wZZvjrqdiN/Jk24VreVABOku0KvWqOHCUHdg
         3xlcZDE5wynrKKk40jXKxK2lQVCx6FmiRScIj/agpsdlbkYin7zFNxkpB7lZZK69y1A5
         LAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717520001; x=1718124801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vQ85ddbl1Y3ttl8lJSOOTPnAC8qpNtaLzkY277e3vA=;
        b=tZRqOv90vWjcIo2A4SWlrTjIeUFQ/VgJNauh6Kj9aH7fbi70IWEQQkSGb69YWEczCb
         18xj6Sp5RYUAJZw5Awt/80eLM+Qk02XElIQHrDaUn5cg2YUqh+aTsnpp3fJT1FyDRurb
         ESJ0H9J4tkA7MZcDBcIls1kfKHQZRU9/GMv5+O9ntG9C2620c7IzGJVUPRdm4ksJPDKg
         +A2ph+FOdSdM7YyDLoQzVa1CFLlBY9DfW8PYmLgVOwmobNHnqUhtGCqKsipgba8ykft5
         h87WXWoh+9JjduLrNW+CSzrnNfDDrt9zTlzw7RKdBWdS0bMSv0tksADhZub4jd/m9W/Z
         wlmQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2OZQqGnbaOosH6Hc/bsTrHrwskybeTKI+p5Rv934A349ZXpvdF9sL/dO7rDfHHoZZIGta24RqNSrBwc1MRi6fepXDZrH7UJ3xZamo
X-Gm-Message-State: AOJu0YyVL1SsX0989Oe6hmRzy3HHb0Ett97jPjlKQ3D2dki4mW5CzHf1
	bWFhaMgFBJBdavqxQwbHMe6CiV8qBhKBT9IZoa293n8zCwQWlM3G+4XAj2RMbf8=
X-Google-Smtp-Source: AGHT+IHvwAhnFmofRW/FUlHCpb2IDlz0WHB2sx85SoTSq8DDRF9UfvrId/NyFG0DgwCG9iB1Id54yw==
X-Received: by 2002:a17:90b:1215:b0:2bf:bb85:edc1 with SMTP id 98e67ed59e1d1-2c1dc5ccdf3mr10534146a91.40.1717520001152;
        Tue, 04 Jun 2024 09:53:21 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1:de74])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a77afb24sm10700646a91.46.2024.06.04.09.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 09:53:20 -0700 (PDT)
Date: Tue, 4 Jun 2024 12:53:19 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	lege.wang@jaguarmicro.com,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [HELP] FUSE writeback performance bottleneck
Message-ID: <20240604165319.GG3413@localhost.localdomain>
References: <495d2400-1d96-4924-99d3-8b2952e05fc3@linux.alibaba.com>
 <67771830-977f-4fca-9d0b-0126abf120a5@fastmail.fm>
 <CAJfpeguts=V9KkBsMJN_WfdkLHPzB6RswGvumVHUMJ87zOAbDQ@mail.gmail.com>
 <bd49fcba-3eb6-4e84-a0f0-e73bce31ddb2@linux.alibaba.com>
 <CAJfpegsfF77SV96wvaxn9VnRkNt5FKCnA4mJ0ieFsZtwFeRuYw@mail.gmail.com>
 <ffca9534-cb75-4dc6-9830-fe8e84db2413@linux.alibaba.com>
 <2f834b5c-d591-43c5-86ba-18509d77a865@fastmail.fm>
 <CAJfpegt_mEYOeeTo2bWS3iJfC38t5bf29mzrxK68dhMptrgamg@mail.gmail.com>
 <21741978-a604-4054-8af9-793085925c82@fastmail.fm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21741978-a604-4054-8af9-793085925c82@fastmail.fm>

On Tue, Jun 04, 2024 at 04:13:25PM +0200, Bernd Schubert wrote:
> 
> 
> On 6/4/24 12:02, Miklos Szeredi wrote:
> > On Tue, 4 Jun 2024 at 11:32, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
> > 
> >> Back to the background for the copy, so it copies pages to avoid
> >> blocking on memory reclaim. With that allocation it in fact increases
> >> memory pressure even more. Isn't the right solution to mark those pages
> >> as not reclaimable and to avoid blocking on it? Which is what the tmp
> >> pages do, just not in beautiful way.
> > 
> > Copying to the tmp page is the same as marking the pages as
> > non-reclaimable and non-syncable.
> > 
> > Conceptually it would be nice to only copy when there's something
> > actually waiting for writeback on the page.
> > 
> > Note: normally the WRITE request would be copied to userspace along
> > with the contents of the pages very soon after starting writeback.
> > After this the contents of the page no longer matter, and we can just
> > clear writeback without doing the copy.
> > 
> > But if the request gets stuck in the input queue before being copied
> > to userspace, then deadlock can still happen if the server blocks on
> > direct reclaim and won't continue with processing the queue.   And
> > sync(2) will also block in that case.>
> > So we'd somehow need to handle stuck WRITE requests.   I don't see an
> > easy way to do this "on demand", when something actually starts
> > waiting on PG_writeback.  Alternatively the page copy could be done
> > after a timeout, which is ugly, but much easier to implement.
> 
> I think the timeout method would only work if we have already allocated
> the pages, under memory pressure page allocation might not work well.
> But then this still seems to be a workaround, because we don't take any
> less memory with these copied pages.
> I'm going to look into mm/ if there isn't a better solution.

I've thought a bit about this, and I still don't have a good solution, so I'm
going to throw out my random thoughts and see if it helps us get to a good spot.

1. Generally we are moving away from GFP_NOFS/GFP_NOIO to instead use
   memalloc_*_save/memalloc_*_restore, so instead the process is marked being in
   these contexts.  We could do something similar for FUSE, tho this gets hairy
   with things that async off request handling to other threads (which is all of
   the FUSE file systems we have internally).  We'd need to have some way to
   apply this to an entire process group, but this could be a workable solution.

2. Per-request timeouts.  This is something we're planning on tackling for other
   reasons, but it could fit nicely here to say "if this fuse fs has a
   per-request timeout, skip the copy".  That way we at least know we're upper
   bound on how long we would be "deadlocked".  I don't love this approach
   because it's still a deadlock until the timeout elapsed, but it's an idea.

3. Since we're limiting writeout per the BDI, we could just say FUSE is special,
   only one memory reclaim related writeout at a time.  We flag when we're doing
   a write via memory reclaim, and then if we try to trigger writeout via memory
   reclaim again we simply reject it to avoid the deadlock.  This has the
   downside of making it so non-fuse related things that may be triggering
   direct reclaim through FUSE means they'll reclaim something else, and if the
   dirty pages from FUSE are the ones causing the problem we could spin a bunch
   evicting pages that we don't care about and thrashing a bit.

As I said all of these have downsides, I think #1 is probably the most workable,
but I haven't thought about it super thoroughly. Thanks,

Josef

