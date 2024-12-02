Return-Path: <linux-kernel+bounces-427203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E94879DFE03
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE66D281BCB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6421F9F54;
	Mon,  2 Dec 2024 10:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWfGgCfn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D6F15A8;
	Mon,  2 Dec 2024 10:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733133735; cv=none; b=F5/9fKLzNt1onwfuEoc5PZyiRv6UhNTrvOO/eyGWCNMuCvIPrSX0HNrxtVa9v6htBeVmsf4sRynmXVLh0jn8ln/gRkZ6GSW1e/q3Zt/deP+wmWhisPr0MFJZnYWQ/Yft6wAoVdOOheskXvn68T8mHgZfUi9DsvOmhNOSciRJkRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733133735; c=relaxed/simple;
	bh=eZ7zlX7FYsKm828GBgt3sagGNQdDzfe4XmGIjJGGhpM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g2Qw2pvzSWnGF5CnTgIG3p8GS9s95XPMOQCyj0LX4wg8P3oK5zdq3RDSoMEeMkPCSD5+azHjoSc9f8atT4gIFskUGO4WpmxoLUJhIU+p1S/DxLkK00oim8AFNImbGGrqHeLO+UJAxKCTDtzXnQkQGDKPDvMolP1ItC2J4sZojGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWfGgCfn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB56C4CED1;
	Mon,  2 Dec 2024 10:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733133735;
	bh=eZ7zlX7FYsKm828GBgt3sagGNQdDzfe4XmGIjJGGhpM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IWfGgCfnvLWSiP0Pz0nAW5fj52PO9cisMN4HES3D4QAPNeo9knjqUEpHdJXO8cq6g
	 pM1BUcPivWLz1NywiawKvs2gN/bA+kIynFMd3cJw5fLjuv57NJDyAmVMzn3IVP6StP
	 sf2gDnjBkciMBqy6dW0VymiyN0eLQmpyXfmTmuHeuQiVq7bEXSWGAJQmniHkJgT8Gx
	 3wB8leWAMEt3b0mAP+futzmq+Hndf7jCQQHY0b8YL7b0Gr2B0oNYL+YHAh9C1xRb9K
	 qyuyjLmz3fOXygwwYXqtM2TX2tq85Redei47lMYFfMVodAB6oJMdfT1Aaia2r+a7lO
	 nvvgKafWPE+EA==
Date: Mon, 2 Dec 2024 11:02:10 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Simona Vetter
 <simona.vetter@ffwll.ch>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 DONOTMERGE] docs: clarify rules wrt tagging other
 people
Message-ID: <20241202110210.5e56d69e@foz.lan>
In-Reply-To: <20241202092857.7d197995@foz.lan>
References: <c29ef5fa12e37c3a289e46d4442b069af94e5b05.1733127212.git.linux@leemhuis.info>
	<20241202092857.7d197995@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon, 2 Dec 2024 09:28:57 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> > +Tagging people requires permission
> > +----------------------------------
> > +
> > +Be careful in the addition of tags to your patches, as all except for Cc:,
> > +Reported-by:, and Suggested-by: need explicit permission of the person named.
> > +For the three aforementioned ones implicit permission is sufficient if the
> > +person contributed to the Linux kernel using that name and email address
> > +according to the lore archives or the commit history -- and in case of
> > +Reported-by: and Suggested-by: did the reporting or suggestion in public.
> > +Note, bugzilla.kernel.org is a public place in this sense, but email addresses
> > +used there are private; so do not expose them in tags, unless the person used
> > +them in earlier contributions.

Hmm... There is another tag that we use without requiring explicit permissions:

	Requested-by:

There are currently 376 occurrences on 6.13-rc1.

This is used when a maintainer or reviewer publicly requests some changes to
be added on a patch series.

Thanks,
Mauro

