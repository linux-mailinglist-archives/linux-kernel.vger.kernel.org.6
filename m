Return-Path: <linux-kernel+bounces-363525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 335FB99C379
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC29628543B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DEE1552ED;
	Mon, 14 Oct 2024 08:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OqmyTgpe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FF31547FF;
	Mon, 14 Oct 2024 08:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894809; cv=none; b=HuwsVzYktiRQ74aqoHjR7PTWc2FxbMIQl2vciRzfmE1XVQAE7TlSKHM87GGqlimNd3fPpNvXko+RiqhrfwxNBsNVEe61pI+7Ev2r0WJ6u6r7pRT4hK2XV6FxH9v8OW/XzvlGZXR8ZJKip41tSwpe198b26mlMjhIjpjIJuKpZgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894809; c=relaxed/simple;
	bh=MwJAE2yIh5yU9vf/fZuB+nwWo5NL+nOgsKaUDOXp2g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PN83zwWyteAo4EDv8F3rl49OYJnAdXvewTWPu6MYF/lkYl9fcEGQ3qiUwDN6HXQf6us7vzaUy+ot9FwBVvQ7DsA8tq4ti/2V9i2q/1c8C/hHmTSZ6stdwYm/9D1grztVDjIDbVUMF+yTE7uKf5fePwkkE9FffhFmRm6PvLMeBA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OqmyTgpe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE90C4CEC3;
	Mon, 14 Oct 2024 08:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728894807;
	bh=MwJAE2yIh5yU9vf/fZuB+nwWo5NL+nOgsKaUDOXp2g0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OqmyTgpeNj6U9GQFwx8h4lLfthfljYymK2oYg7c8YeJK32uDTwhBdue8QZOegF6UM
	 KpOdCpX6mu4T7BNI/p/izuqOhl/p8lzcHmH+HwQIOaVkHH9PTkef6DwBXWbooyTYik
	 LH0FsYeygT2uLm8YA0IejqCXdOsqKuGaqdP3682U=
Date: Mon, 14 Oct 2024 10:33:24 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Dominik Karol =?utf-8?Q?Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: "dpenkler@gmail.com" <dpenkler@gmail.com>,
	"linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] staging: gpib: Proposal to add TODO file
Message-ID: <2024101415-stamina-conch-56bd@gregkh>
References: <9kl5ApXnxfAqT4f8YvoMMU8hLdNC_Dd3ZfZj5UEGrLfWKU_PnImmkF7ZIFgiSq_Qt06oFVAQ04JfzSwfXree6_ZZ39c9d58Gd3rxCCZ2jUw=@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9kl5ApXnxfAqT4f8YvoMMU8hLdNC_Dd3ZfZj5UEGrLfWKU_PnImmkF7ZIFgiSq_Qt06oFVAQ04JfzSwfXree6_ZZ39c9d58Gd3rxCCZ2jUw=@protonmail.com>

On Sun, Oct 13, 2024 at 07:45:33PM +0000, Dominik Karol Piątkowski wrote:
> Dear Sirs,
> 
> The gpib driver was recently added to staging-next branch, with patches being
> few weeks old. It is currently almost 30k lines of code.
> 
> I suggest adding a TODO file, as majority of drivers in staging subsystem have
> one. There are some things checkpatch complains about, and maybe there already
> exists a list of known other things to do. If such list (or lists) exist, in
> any form, I can prepare a patch introducing a TODO file for gpib.

A TODO file would be great, thanks!

greg k-h

