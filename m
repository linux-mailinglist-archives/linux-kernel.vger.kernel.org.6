Return-Path: <linux-kernel+bounces-344779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CA998AE2D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9686C1F23A1B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE3419F10E;
	Mon, 30 Sep 2024 20:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIdJtHOU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA3147F53
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 20:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727833; cv=none; b=RPmfmpuC8x2jCAwT9ENsNN3NkM1VsmefroXpn0AnHARqgG7srIXBiZXue10GKqEYLtcQuv26g+ha6izZ97XHKnapF2ZKcqsZPU7Yu5Wz0duHkr7MCrXzRATGxd9C29Y0vI7i+Rk0HoEU8YZjlHXejYrCsJgyEF6YJ6t23GPcQdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727833; c=relaxed/simple;
	bh=FF8dC333muyHMHgiYhZICsRbsvjF+6WtujzvulItblI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/pHqHyxGBgTrTCv/J3sarjYNJ2VmspxzZDSefxFyN2PBZTa2PqwfYb8orLQhl6dVPLEJ3ljFqQsDPSNn5DyQeWvFMjI8O9hvix1D+eFn3KVN34qlZD4MdxIVU/ta8a8Ku9J1GA4ztF1uL6anwCsRH4DjArM+E2wy1p9bP40eXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIdJtHOU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8E5C4CEC7;
	Mon, 30 Sep 2024 20:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727727833;
	bh=FF8dC333muyHMHgiYhZICsRbsvjF+6WtujzvulItblI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EIdJtHOU+K22NW+ai5V2ppDyTOQkzTkMhmPrcXb6imsrtwS7bk4kwq5EDF80ZANJl
	 5bDldT2JPJZI2qZFdsJ8hbd6k1F8vkRYbnWy2mGxvanJdvunPlIMuHru+inKJZK5yL
	 ENBWCs+v8NzAXV3KAQhiEz4hif0CkCga+NbJbVLNVVKg7fMD+mk20FUn1ZF6joQPYU
	 x88ntMefZHWw+jA2c2sjo5X22I/uMuz+dp4LdkV/+uUwcf46Ow9JPrHz9WntgGAqKh
	 Dqe15m+WpsHTJpF3XYSdH8pfzipk5z9nr6TAw+O9BGNWfxSu+bXMsvxy9MU4tehIJm
	 rPE1qYqje0H2Q==
Date: Mon, 30 Sep 2024 17:23:50 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
	Christian Brauner <brauner@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/1 fyi] tools include UAPI: Sync linux/fcntl.h copy with
 the kernel sources
Message-ID: <ZvsI1lYepcADsyMC@x1>
References: <ZvrIKL3cREoRHIQd@x1>
 <20240930.162315-undated.permit.modular.catnip-THGkg7JTJlP@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930.162315-undated.permit.modular.catnip-THGkg7JTJlP@cyphar.com>

On Mon, Sep 30, 2024 at 06:24:50PM +0200, Aleksa Sarai wrote:
> On 2024-09-30, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Picking the changes from:
> > 
> >   4356d575ef0f39a3 ("fhandle: expose u64 mount id to name_to_handle_at(2)")
> >   b4fef22c2fb97fa2 ("uapi: explain how per-syscall AT_* flags should be allocated")
> >   820a185896b77814 ("fcntl: add F_CREATED_QUERY")
> > 
> > It just moves AT_REMOVEDIR around, and adds a bunch more AT_ for
> > renameat2() and name_to_handle_at(). We need to improve this situation,
> > as not all AT_ defines are applicable to all fs flags...
> > 
> > This adds support for those new AT_ defines, addressing this build
> > warning:
> > 
> >   diff -u tools/perf/trace/beauty/include/uapi/sound/asound.h include/uapi/sound/asound.h
> 
> Thanks, feel free to take my
> 
> Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>

Thanks, added.

- Arnaldo

