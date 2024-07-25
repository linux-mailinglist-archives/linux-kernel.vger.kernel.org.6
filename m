Return-Path: <linux-kernel+bounces-262660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F8A93CA29
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 23:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F26071C2167E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 21:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668EE13D893;
	Thu, 25 Jul 2024 21:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZDXQR1cI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB55F2746C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 21:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721942839; cv=none; b=TlBLCwia9vfnoavtaQUcKK+HDxQZiTdUr+hXeOoY1QtAyAJcvpgNhvp/Ye6gaGIyQK6u8pYdhY1S5QLQqkLbNLilkMWh5AW/a0TWz7CV9XpneqS4V+UFg86vZrkCPyK1nDve1X3v1xgh5FiawfhviW0kOEqxv7HKtV7LOBw0Syk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721942839; c=relaxed/simple;
	bh=+VsB7VllEJZkJd3KHqTrfP19Ch0+6lWx7/scESCiW54=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=E1Uew+LZZs2P6SZQ7NweYEqKxDczt61QZ8S64AJWKGNLGt4myZgClw3Um9nOYtAPZBJXFkf53QBzuS1nIswYJ3Evgw1wx084REda93Ql4AJIRscwnDGft17Jh7aUn8rSQIsB2DiuS1wp8iIiTzvAL3cAHYat+6GsMRQ7IrZ7b0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZDXQR1cI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F1EC116B1;
	Thu, 25 Jul 2024 21:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1721942839;
	bh=+VsB7VllEJZkJd3KHqTrfP19Ch0+6lWx7/scESCiW54=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZDXQR1cItH1hoF+gkZjuykSNYhVgphyQfVz+tYA35o+9rGZrwzXoMtDsqGONeEkZX
	 bAUXoVdwdeeupb9tjN52LV1yjNbfm/qde13tRQmIif9el3jQ+m9UbYoWO8xt0RYA2Q
	 kFuWyUB1GgF/YTlWgTbBJLU5WV6HPsitqj4KLIVU=
Date: Thu, 25 Jul 2024 14:27:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Steven Davis <goldside000@outlook.com>
Cc: chengming.zhou@linux.dev, hannes@cmpxchg.org, hch@infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com,
 urezki@gmail.com, yosryahmed@google.com
Subject: Re: [PATCH] mm: Capitalize letters for readability
Message-Id: <20240725142718.b320d59cf52f250392a9a47c@linux-foundation.org>
In-Reply-To: <PH7P223MB1039AA3BC1E999EE54B1230AF7AB2@PH7P223MB1039.NAMP223.PROD.OUTLOOK.COM>
References: <20240725132124.b0d317ba1d9e7d1651b71a65@linux-foundation.org>
	<PH7P223MB1039AA3BC1E999EE54B1230AF7AB2@PH7P223MB1039.NAMP223.PROD.OUTLOOK.COM>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jul 2024 16:49:51 -0400 Steven Davis <goldside000@outlook.com> wrote:

> > But I do think such a change is too trivial to justify churning the
> > code around.
> 
> So how do we proceed? I could move onto another patch, or, as you said,
> change everything and add a checkpatch rule.

Let's not bother with this, unless others feel more strongly than I.

