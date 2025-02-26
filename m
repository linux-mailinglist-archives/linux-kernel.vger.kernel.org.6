Return-Path: <linux-kernel+bounces-534867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1C5A46C05
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 571F9188C288
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A746727560A;
	Wed, 26 Feb 2025 20:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BtVbvxiL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF93275602
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740600505; cv=none; b=V6QYRVzE8r7OqQnYYqYmCfhoBWznajfM8GmcZY7n7fAfivQexejS7CrsYxOsfos00Qhuk60hHV4lVuicZV7l65S0pmN+al4k3ajxvNAi7Ztljem0U7Bh+GA7s3y/66jX9QARca6OgE1XK5Vg9y2dduV3e4DvweshWTQJMigwNKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740600505; c=relaxed/simple;
	bh=WvwEOgxxDcmlsWJ2W4svJ1g+fpI4JskHUYyEpi0lqZg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZozaquheKnwXgJxYIixtqHd+mNJIxfRUBbNVDTcfZuOwaK3oV5SZI4iYgm4Zm0QTBbr/+g387bywquVv4RwxTQQl0pWmDwRi7/076SA9nSbeSLA05Oz1Q95qdkM9B6sahm5d4i3Jd3mokspwnKqqQZ66eKCoWgxBOUB5cjOc19A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BtVbvxiL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704C2C4CED6;
	Wed, 26 Feb 2025 20:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740600504;
	bh=WvwEOgxxDcmlsWJ2W4svJ1g+fpI4JskHUYyEpi0lqZg=;
	h=Date:From:To:Cc:Subject:From;
	b=BtVbvxiLy1tVp5Fh5rgwDMNPFXhjRzrg5xlic1F0AoiyIYqUIJR9dN0K+rgyGwwTO
	 QvZtu1gIYPsWoVQOwWPNzFxHI3nxc3p9k006JDYNcv24N05k8Udpx0h3a/7Mr/0NL8
	 vHlAFzcceK1r36+TLCN7BIXHlEms/WjqElu5TK18=
Date: Wed, 26 Feb 2025 15:08:21 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: users@kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: git.kernel.org -> web.git.kernel.org
Message-ID: <20250226-enlightened-dragon-from-wonderland-09c2de@lemur>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi, all:

The change is now in place -- all browser requests to git.kernel.org will be
redirected to web.git.kernel.org, which is a CDN service currently fronted by
Fastly. The backend requests for web.git.kernel.org are sent to a dedicated
set of systems that are separate from git.kernel.org frontends, so hopefully
this will help shift a large chunk of load from the systems where we actually
want to serve git and lore traffic.

Please report any problems you encounter to helpdesk@kernel.org.

-K

