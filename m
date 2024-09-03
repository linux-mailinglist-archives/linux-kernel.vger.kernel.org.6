Return-Path: <linux-kernel+bounces-313293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F1C96A350
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8F041C23BA0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063E9188A01;
	Tue,  3 Sep 2024 15:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVKykKki"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4F52A1D6;
	Tue,  3 Sep 2024 15:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725378619; cv=none; b=g2s+sNb8HcXGfPGPYIXXVCBo3h4W5Rqna4TG8YpJ2pAuKUiZLAfg/RaXcxSjCpIwqGvwbzFCAKmfxi0Pdb8cOaZ/b80TTwU390W+yQOgztWVmOeQtyptB4HcEYcrXubc7rfYcGHMZVoRQfw7EdzWWJpm2YnjvKVN7Nj9RIRvJz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725378619; c=relaxed/simple;
	bh=TtjIUZZE5FgqS/EpHIHpt9Y9fP+E0Y06nqTjuHq5Qds=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aPUwdsxnBDCdpmRhwjQrsvFGhQSp8aak0BMcigGF0kEX7lfdprVQeDhucEmHCEKxieFNzrwiKvbySfJ2uPvdvWGyZSaiak+eudH+rPWnKqpEuPTt7sL4U5rMIoRvkXjL7GRs6l/l6rD0HNVW86UAFNJ3w9JApZuqHsmlSTB4IjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVKykKki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B9BC4CEC4;
	Tue,  3 Sep 2024 15:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725378619;
	bh=TtjIUZZE5FgqS/EpHIHpt9Y9fP+E0Y06nqTjuHq5Qds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GVKykKkiyfoYgpKtnWfiTb/VXofT4/82oemLmE0hNrmIv+SGixsc49R0eHqyCNdgv
	 6t6wO4FHgo4HSy9jgH5SZLXi3igLwVWMd6kLM7wwUbG7w4GXPEct26QjPW8BB0vnFH
	 BV4KWBKlXzBLfEi6+hR6CDIHxwYu+r56EGnlBbRUWGfSZgD9NKUQ7nUtfcQMfX5Cun
	 JXEwTAPfuJsSBpQ2kb9RH8egb3ocRfYToD8xv4l1LIAmqVP+ZbcyZSwMWZRK/hYzc8
	 taGTsnDX2rk3EQePy+koyxpCioH9CXj1LhjY2EsjUVfnxxdW3DhCwWFNP/VLnRb0ey
	 K+pWPfmlTyipg==
Date: Tue, 3 Sep 2024 08:50:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Steven Davis <goldside000@outlook.com>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: maintainer: Improve grammar in mailing
 list participation section
Message-ID: <20240903085017.6dadfd4d@kernel.org>
In-Reply-To: <SJ2P223MB1026BD1839CFD474395FACDEF7932@SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM>
References: <SJ2P223MB1026BD1839CFD474395FACDEF7932@SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Sep 2024 11:19:25 -0400 Steven Davis wrote:
> In the section "Mailing list participation", the first few
> lines had grammatical errors and overall was not clear.

Not clear in what way?

> I fixed this by adding "The" before "Linux kernel" and
> specifying that the mailing list is for developers.

That's not correct, the mailing lists are for all sorts of
communication, not limited to developers.

Ack for adding the missing definite article but please don't
"clarify" the text in ways which make it less correct.

