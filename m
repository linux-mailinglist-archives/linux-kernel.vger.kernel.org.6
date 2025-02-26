Return-Path: <linux-kernel+bounces-534739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 155B2A46A99
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 249D13ACAB7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743252376F2;
	Wed, 26 Feb 2025 19:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xw/Eo1Ef"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32E6220680;
	Wed, 26 Feb 2025 19:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740596750; cv=none; b=IefVNGJbmkIX0CSDven566G7gJBhsMV7bnj9MnQPMbHJyb4Ee8LD4UDq6UoJ9uC+T0t/jmM6IFfByedAylcT14CnM1dsIowsv5OcEpU7v6PUAJDPvrmb7QFLqT1wdt9NDkPvsXho6nporM6k0+gRW6w3v/FRgyAgnQ3qmmsEU00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740596750; c=relaxed/simple;
	bh=db+0kN85YleL7+ViaUwtcVt/teA2jl6oEh70tfeOrkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iZ3Hnpas/FbJ+nQpMnaV1L7ED63WMkB50bQb/4J5TiqmZ0MlFLXM3LEZm1shaCv+ma9ICPAYqrDZQ7lg9ViGes0h603NZrc1aqruMI9ufc3fjlwHMmgn1tVe0Ob4I7Sp81GXvnqa2La5+JC8n5LGUksGTMeVp5b1PfTxP2jnwRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xw/Eo1Ef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28694C4CED6;
	Wed, 26 Feb 2025 19:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740596750;
	bh=db+0kN85YleL7+ViaUwtcVt/teA2jl6oEh70tfeOrkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xw/Eo1EfQHfW4WwG+zSoT0A+bFTEDIg3/VZ5+ZtQnfqdXD+0kM9Z78pOF5WfjMPrW
	 8Opkq+DFGRMp7k4JQMZXakhslI4shHxbCgx3tciuGWIC9TDMaXsiiPY6FoBrYoK4Z5
	 ZKxsv2baooK+jq/XvtcDDNxq3SZhHn+nDM5zcDcyZU0lYhf/Ky7ZAcUvwG7D4EIBKf
	 fvXojdyafpZXr9XwJ8rMYdUM455EaiSEepDxpkHkC3jCwyrVJEk3LnglwbaOUqt/W0
	 asSZn4NBXlanxv/plxRDmK2EfOTWkvlfxM0ikO0i8ACw8QN71CubVK7f0YINoCr1I6
	 /HzRDqv0r01TA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	bus710 <bus710@gmail.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] samples/damon: a typo in the kconfig - sameple
Date: Wed, 26 Feb 2025 11:05:47 -0800
Message-Id: <20250226190547.66725-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226184204.29370-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 26 Feb 2025 10:42:04 -0800 SeongJae Park <sj@kernel.org> wrote:

[...]
> Chagens from v1
> (https://patch.msgid.link/20250224180709.2167187-1-bus710@gmail.com)
> - Wordsmith the message

So this is v2, but I mistakenly forgot updating the subject.  Sorry for the
noise.


Thanks,
SJ

[...]

