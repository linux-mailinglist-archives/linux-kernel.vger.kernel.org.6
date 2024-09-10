Return-Path: <linux-kernel+bounces-323902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E03FB9744E0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B5C9288606
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 21:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3711AB507;
	Tue, 10 Sep 2024 21:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="keEeJz8a"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25006190047;
	Tue, 10 Sep 2024 21:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726003918; cv=none; b=lw6KX7w2sNjG9/yYk5XPs8ETI+hHpDtF+rRuvWViksxAumXGkKlmwBjBKMWzfxpn56CIu8cDdqxN5WP/QJXWmfMTotsv8ysUsAWf9fuRVwL9UE8N+i018I6lmZQ5vnrOyT9S912tqV/M1J+E2tODPV4fQ7FuJWUxgJt0gw4x+b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726003918; c=relaxed/simple;
	bh=PzxW8ciUnjyV4ouayaimH2TRkYAfBmP4wHKcNb0f0ys=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sM0FOk+EAXxp8lEgkAGD6NcjaW0q0N2UmqdLULWDtr+UdMJUIbN5WvuoKYANbSs9gHrRTWe8e0iIQIX5xOohP2EuSXAqsFHOsT19TYmc6mhePdNYTOfq8dFSWp/lARHVFdx43FpmgUm0dPt5qAcwrwa069sfoe/xE+UgRcTrlhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=keEeJz8a; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 594634188E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1726003916; bh=LBcixP50v1s5ML8wzLF2MTIwls0FEXwz5SOsK0y0GKY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=keEeJz8ayIxQtFzPAr5kf76xfkrTKG1QAdAnyaRO/N5kjHQk0fumZiP04Anm/u9Pd
	 pdRpBDKB4T8ganEWlzVEx0jGq18xJ5Xe248/50qdGKoD7QHxn4KmnNOEMTi5YbOtUH
	 Y0XsqJ78inQDns+aQg7ROhWPO+bTx6Q5XOryPLt+wrc832iLfkob9qAS/2sTtyZtFl
	 3l7sUAwf1VyuatoUJkw7OJeZYzU4lNVxKNLQgFhM3pFKAWtGGvP08i7oQGq5YMVwKn
	 pn1G2XtIW5D1g8t7TJfunAWEemXweefjWlLsfz18Jv0wSpBksO5VGVc5KDWThxXttx
	 +RqSTiETecK4Q==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 594634188E;
	Tue, 10 Sep 2024 21:31:56 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dennis Lam <dennis.lamerice@gmail.com>, nir@lichtman.org,
 rdunlap@infradead.org
Cc: Dennis Lam <dennis.lamerice@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs:mm: fixed spelling and grammar mistakes on vmalloc
 kernel stack page
In-Reply-To: <20240906204914.42698-2-dennis.lamerice@gmail.com>
References: <20240906204914.42698-2-dennis.lamerice@gmail.com>
Date: Tue, 10 Sep 2024 15:31:55 -0600
Message-ID: <875xr36vqs.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dennis Lam <dennis.lamerice@gmail.com> writes:

> Signed-off-by: Dennis Lam <dennis.lamerice@gmail.com>
> ---
>  Documentation/mm/vmalloced-kernel-stacks.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
Applied, thanks.

jon

