Return-Path: <linux-kernel+bounces-396801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2742F9BD255
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D376D1F23270
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB261D6DC4;
	Tue,  5 Nov 2024 16:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rn5MK5Sv"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6EE1D5AB2
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 16:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730824183; cv=none; b=HuV6zBHkMP+PfJ72jLMU+R+Q8jWapZAwkkMeI8R/PGIlG+pMhUfT0CyWYMB9MKnadMId8/UnMKgXfmFquMDFu9Xt0K1wWZE95FbVhqSI9H+JKVHI36OpSPlKFyxR/qsmw99yk0CXt/BsdS2YSN8HgUNuOvBxkQY6VADNhPzOvSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730824183; c=relaxed/simple;
	bh=XwjeNRmkuCKUxhgVPhaLmI+EG9+I76n/DKjkke71v8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9JIQyY4EheP8p9SY3tPW/nSfLzznYnOp18R1B9Y32lQLSAzoApbf2YVhgm+I+P3bcVRBGQ3Z+wHsEMeFWp2PleKmq+ot0GuCKWNmWOJIRREmL+A0p8ORdTprqT5CkAyjeZuKKog6IdzvExXZdTMQMpvw5ayDHkdLvJ1k9CLlqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rn5MK5Sv; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 5 Nov 2024 08:29:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730824174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6kDUDUiXptOcsORLavTz9SKtohT5ZOPJJfztWgChls0=;
	b=rn5MK5Sv1KdoHGDhgrBvvWVp7lDmmZMTgTaB2mq/n22r5eTFRzjvXIMs/J/6w9UCfqoOx9
	C6S1le1ijnsPHKmz73QBNfGGmaCxvuoJUSiisXeES0jkWZLa1i6sV/sGC3z3Dl4olyrR3R
	k9X8p/wlu22zcUhcQOQxz/HCgIn1DRM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Keren Sun <kerensun@google.com>
Cc: akpm@linux-foundation.org, roman.gushchin@linux.dev, 
	hannes@cmpxchg.org, mhocko@kernel.org, muchun.song@linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm: Fix minor formatting issues for mm control
Message-ID: <q6o3lkugrlfxj4q7sblff6ktqj3lvob7u4vkam4fmafm2fbw4b@624v4eesyavv>
References: <20241104222737.298130-1-kerensun@google.com>
 <20241104222737.298130-3-kerensun@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104222737.298130-3-kerensun@google.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Nov 04, 2024 at 02:27:35PM -0800, Keren Sun wrote:
> Add a line after declaration as it's missing after DEFINE_WAIT(),
> replace the spaces with tabs for indent, and remove the non-useful else
> after a break in a if statement.
> 
> Signed-off-by: Keren Sun <kerensun@google.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

