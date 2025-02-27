Return-Path: <linux-kernel+bounces-537093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F57A48807
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C473A3B5A64
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23781F5852;
	Thu, 27 Feb 2025 18:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhgHnQSj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D981270023
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740681835; cv=none; b=A2DsghsmDq+Yxx6TfbzFimq8npbe348BeJF1YE6Ni1tinJ+s1cwESW/pF8XUs6rTGp6GCvih19c9QrRy/cqnfsYZKrAQkCjbIxmmoK+0BHxNdoUHilJEtbhKXzx6Bfi+PMIOfjLaTPNHx80txDcL6zHK5hPQR/SL3Xz/wdJc5Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740681835; c=relaxed/simple;
	bh=WNUGkfPvmI2xzgeYt2Ian/NCJ+ihq7kxPyXENanJiJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jJpi9lklfvoMjibVqulqOMA898hLQtuzg/SkeuRV+/+BK8KPAgzIZTIEfHF0CBXMsAumnxb+HgSl/33MnlsieSYxhUshqnUBUNJg2P07ZZhr+k3VjIM016TX60G3/+Xv9G2HAMUVPxAQRmPnx+o9MjK7jm+RpT5pnFrhw4meB9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhgHnQSj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9935DC4CEDD;
	Thu, 27 Feb 2025 18:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740681834;
	bh=WNUGkfPvmI2xzgeYt2Ian/NCJ+ihq7kxPyXENanJiJM=;
	h=From:To:Cc:Subject:Date:From;
	b=mhgHnQSjW7h060d/IudUh4S75DmWIErP44s1vLNHzNFAmQuobY6MinhFami79YIkC
	 opD6e7dbCGOyP3xjNbUmdqPSdeh3AtTdsgzGMfgoCvegH1jsKnTNJcB94/FmsrEutx
	 61UqBNUNZx1KlHXCT5QVvQj3/o7jSJNiJTVDIq2qM2dHwHGOLfunUIFKMMK8b2hwCG
	 XGEFVH+u4oQp0tIFlbN0vZKh3nl3sB5JH6WmFDJwBOvqAuzcbA328a8WWIJN0D7vOi
	 wBLcGwfKyin5euhs52rSDaV2qHH+Y9Gt8yyRv5ufVB5MuOnNxjuR7yyHOVQqN/m7TC
	 iV4HQNoN39iAw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Joel Becker" <jlbec@evilplan.org>
Cc: open list <linux-kernel@vger.kernel.org>
Subject: Helping out in configfs
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 27 Feb 2025 19:43:40 +0100
Message-ID: <87cyf3p6sj.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Joel,

I saw you lost your co-maintainer for configfs. If you would like help
maintaining, I would offer to help out.

As you probably know, I have a series of (rust) patches that I hope to
upstream to the configfs subsystem [1]. I assume I will be maintaining
the code from those patches when they go in (?). In that case, I think it
makes sense for me to offer to help out on the C side of things as well.

Let me know if you think that would be useful to you.


Best regards,
Andreas Hindborg


[1] https://lore.kernel.org/all/20250227-configfs-v5-0-c40e8dc3b9cd@kernel.org/


