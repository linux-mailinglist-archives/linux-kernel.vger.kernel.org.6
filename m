Return-Path: <linux-kernel+bounces-547733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8161BA50CDE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C21B81885E37
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3722561CD;
	Wed,  5 Mar 2025 20:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXDJ53OH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8F024E4B4
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 20:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741208242; cv=none; b=Bm7QuiAULoRESljH3Ae8hQpgXmn708g4HdhKBZeMmVbEHGjOxNELyMunuvCUEVBqip0MiMghc2N4W32BSTsJLHJyK7eozTREezkLk4My1U//AqepmOWRwqAR3HuG1mkyjjnD0/tH/41U6kQ/Isei/4C7Wu36jHOUkV3oewK+1NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741208242; c=relaxed/simple;
	bh=xWe/JBT3h/Ow05UIrGSOTAiX8BSXaA2UbpWUZ/6ElxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2ZVxEcQpNvK/xwWKNrlMnCjxoTsmZ9goWTG359gNb0A4JjPodSkxdrJcmUQCJ6smPHOkmkwkRLzM2y0DJRF943lAbQPDrkvs+eLYk8Vhl23KPR0uWDHeBnducESCG1o9cuq9cfZsTw859EhA4oUdVJzDNNURKbFc8hTXRy4QAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXDJ53OH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA464C4CED1;
	Wed,  5 Mar 2025 20:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741208242;
	bh=xWe/JBT3h/Ow05UIrGSOTAiX8BSXaA2UbpWUZ/6ElxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fXDJ53OH8NabnOw8Xywh4/FVhLkjMvsQ9uzt7eq5rmS0XX6Qn56ebRrs7cm/C8BYj
	 jdRRkyjsGc53eJyRNJ3QlzBHoWMX/B6Lrn0Ntf+zyqZBSsY/f0VoqY802HRUw0k1NX
	 0PERPiohVYJVhuL/tkOLjqfxK2K8qkvAogRimUa7NPJI0pf15+Ia3t6mKZy8e8t/M1
	 HrvoVVniJ2Yf+DLVFLjZobMH9M97a/CDvLKsUOmpFzkz8trP2CRYRn0VlXGxuNZNb5
	 P/qvJHOuBR+OrFAb8L9cO1ty6qGWg3kR4g4UoJaPGu8GeTYDJd6LusbUiFOQKEVFNq
	 zFownuAbJgpxA==
Date: Wed, 5 Mar 2025 21:57:19 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Benjamin Segall <bsegall@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrey Vagin <avagin@openvz.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 03/17] posix-timers: Cleanup includes
Message-ID: <Z8i6r88cYbHrNRSW@pavilion.home>
References: <20250302185753.311903554@linutronix.de>
 <20250302193627.103677445@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250302193627.103677445@linutronix.de>

Le Sun, Mar 02, 2025 at 08:36:47PM +0100, Thomas Gleixner a écrit :
> Remove pointless includes and sort the remaining ones alphabetically.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Frederic Weisbecker <frederic@kernel.org>

