Return-Path: <linux-kernel+bounces-560941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A91A60B3E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 450B53B019F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C4A1A5B81;
	Fri, 14 Mar 2025 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkwD3EPW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D28433A8;
	Fri, 14 Mar 2025 08:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940600; cv=none; b=jtVt93zc1XRGYA9+XYi38DoQ9RwqhPpx4ZzDg+LYTNnbIw3sU1WNhnwmR4/R6auw+mX25DwLgBJGi4T4NvoRkgW3nuuOLynLcwrHy+MU2Y6OVe3RhN5H0jEbmUqW09Lg1Yt920iu9BzO6T4oIVOyVduu+yEhXztrHXpmwtSzZCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940600; c=relaxed/simple;
	bh=1s++ZSJYRJcgQ+c8JYiNCM2fJc19mYYu/ys3sTIVp2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HO17Z30sP1jcEEqHYg9CSDLWR2pPyE4LGJmgesRHe2WS43pdM70odtULUjRul6tyNB8sD9keklVGCKrOD6foA59zERr66DGkdUAXLhah7+JCuxvlSHunbpD9mdqIiRqPFmk3kYT4+nfsn2JJzuQZ3zMOb6CqIbncFpwqDUkLD9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkwD3EPW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E451C4CEE3;
	Fri, 14 Mar 2025 08:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741940599;
	bh=1s++ZSJYRJcgQ+c8JYiNCM2fJc19mYYu/ys3sTIVp2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hkwD3EPW9wiwvqzLgJ/WlgFFsD0dnwBfDX+B70vpkoOqv9rGFD8ISY0UAXS8DVah0
	 aOLoKxY1Im22LhmAfJ7xe1/mOVZFDXUZqFaZt1nfthh+WnzTudYH6+na8OA3HsIMRf
	 lte2zDvUk+UNZmLvlGpgEbsP77astv5B/IjMDJjboEGbh4/9mFhgzb7cLf6Vxd6X+S
	 p1zmzDc3VWILSPZNDj/CU0iR1wJ9nHuAU4HzGx6F2hkfY/SR+7sLoHlLdiNLQaaS6N
	 4Nk9f2lieI380gLLR3s5gmyQ2fqTvSQu7E0gob+t3jP8E9+5UJ2irFFC/mUIjAjkaB
	 I9ifBuR8qquWg==
From: Maxime Ripard <mripard@kernel.org>
To: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH v2 0/2] drm/display: HDMI documentation improvements
Date: Fri, 14 Mar 2025 09:23:14 +0100
Message-ID: <174194058300.3849846.7214502528190866925.b4-ty@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312-drm-hdmi-state-docs-v2-0-6352a5d68d5b@kernel.org>
References: <20250312-drm-hdmi-state-docs-v2-0-6352a5d68d5b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 12 Mar 2025 14:39:15 +0100, Maxime Ripard wrote:
> These patches improve the HDMI infrastructure documentation, in
> particular to mention that edid-decode can help debug and check
> infoframes issues.
> 
> Let me know what you think,
> Maxime
> 
> [...]

Applied to misc/kernel.git (drm-misc-next).

Thanks!
Maxime

