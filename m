Return-Path: <linux-kernel+bounces-513269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B654BA3477D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D68618937E0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F0A156F3F;
	Thu, 13 Feb 2025 15:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ai64S+fy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C743326B0BD;
	Thu, 13 Feb 2025 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460557; cv=none; b=X8/GAKyevyINg+GHcimov7vA6VtM7A0usK4k0DL3baISx+xmqDUkQHLZmBJKvyfvpLG7FfVtuCyWzXZTRHtIXrwTlLJUBGGyojSPQ7hteRVa7muM7YZKFpOz9mlbKZ1z8JZuWlNQIJAWmD9ABhMwjHnxpMy+8rKrjWwkHGGpdUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460557; c=relaxed/simple;
	bh=fnRHXIO3iR4FILihld/26mWyXq/cYQJrSjPBFQ/cX5g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TwsbdtdhqyCdV8iKMLBXqPYDTEALVnwGWDjpJcKm0m97Lq3OhOGdz+TCBkX87VNd+CDKBAtx97J+Ga5Eb4EZ3yNDppDZ2OErxaN9n/8vjYpO5U2/PGlCp1b3SG25Htar1TwUp/We6wns00vfaELyUqRj8tAz3pqeSDkF9zJKWeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ai64S+fy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED63C4CED1;
	Thu, 13 Feb 2025 15:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739460557;
	bh=fnRHXIO3iR4FILihld/26mWyXq/cYQJrSjPBFQ/cX5g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ai64S+fyPgE98akK08UudFO1xDVEN49B2eU/ZbrBuuc2DrNYGDOJ48hholC6BSafy
	 BUL47mbV0UoolepCN4S88mU/LGcLPGPZ7I3T4dDU0yCKWIZyyFCa+Qa/N1qb0OfN3D
	 TYpGi73Or+45GrnPe/FlQYeL2SYgvLk6iu8cDz5MPi4+rHbQTecRVG9+p/Oexsq3KY
	 Rtojpn6J7HOqQFXM0Ut/q+UBDg9XBvRrVmARD5qbpX+s+EiYv8n7jWMgX8IFqxYzAM
	 o3JjXjFQwTxOFBrXIj7hocJILO6iQEXOK2XBq3ALfp/pP+BJM6HhxoaTdQxl1Gj2+A
	 UhlCinQQPWW/Q==
Date: Thu, 13 Feb 2025 07:29:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Mateusz Polchlopek <mateusz.polchlopek@intel.com>, Marcelo Ricardo
 Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] sctp: Remove commented out code
Message-ID: <20250213072916.42457bba@kernel.org>
In-Reply-To: <F83DD790-9085-4670-9694-2668DACFB4C1@linux.dev>
References: <20250211102057.587182-1-thorsten.blum@linux.dev>
	<b85e552d-5525-4179-a9c4-6553b711d949@intel.com>
	<6F08E5F2-761F-4593-9FEB-173ECF18CC71@linux.dev>
	<2c8985fa-4378-4aa2-a56d-c3ca04e8c74c@intel.com>
	<20250212195747.198419a3@kernel.org>
	<F83DD790-9085-4670-9694-2668DACFB4C1@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Feb 2025 11:49:45 +0100 Thorsten Blum wrote:
> > In the linked thread the point was to document what struct will be next
> > in memory. Here we'd be leaving an array of u8s which isn't very
> > informative. I see there's precedent in this file, but I vote we just
> > delete the line.  
> 
> This patch deletes the line and I'm wondering why the "cr"?

My bad! Misread the diff.

