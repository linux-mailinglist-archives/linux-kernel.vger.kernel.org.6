Return-Path: <linux-kernel+bounces-391589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D16C09B8901
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 03:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 974E32820DA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 02:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC09132103;
	Fri,  1 Nov 2024 02:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oU7Cunw/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7393C1EA65;
	Fri,  1 Nov 2024 02:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730426528; cv=none; b=K05ivkT4qJ5ZSHNKfjfSteXg1wqDzRaYTPda2DnTvxr+cxyzRTfOM32XF+LDNcmncY2Als4fDewLgMu1Mw8HlXnh5lO1E/rCZs2b3wQiDi7Ah/Sj8KrjL9ujJLudNXsKvIsgeeD9xtcJyW+fpR3jo2er1aPcAPm6GezhqL2UDXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730426528; c=relaxed/simple;
	bh=00Qzs0zLAQpvza5LdbNUpf4OdZ8Rc7JiePkFOhbFX4A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R/ofYb6IKhStywRhJwgY39nn7fJoRigOuv/lmydYUPWYRS22s0CIe2b0iBfzD8tBbtjnJrnNt1z+lCNN5IsgdevuL0N6OZYOSvvuk3z1BFMaJbRZI5FLyPMpG9K5t5z81/8qlkLfgUhtfUN5gT5p/fviypd6VtFEgr/2ez4mBzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oU7Cunw/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C70C4CEC3;
	Fri,  1 Nov 2024 02:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730426527;
	bh=00Qzs0zLAQpvza5LdbNUpf4OdZ8Rc7JiePkFOhbFX4A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oU7Cunw/Eu2gpa6G+pancwyFwb0Lv+AYQZYY7SJPFaBtoeBGHyQ/soBnDO87qBXKH
	 k139dZPkQbsvrJ7mMXCANSURqzaTQ25Hm0JwMJjLaoKLouFPccIf+s5kNLLpmOydlv
	 jN+vu7V6CjHiXrZr4vRWMzG4HeuGIV5t96TAG2jf+V0KdYRSTM8/FuiRk7AmSCaB3i
	 bB/0i8c90S3Eiv3GAhG5QsbLmwXvQal2Sl4cJ2QIO2jvr2Xae2nVgmiUNmC0PzrnWS
	 v6jIRG3DbgFifG6gF509+UxfKoxXIw3TF+1NuS01iC3o22NjZrKInu7UWAXHH5oIJv
	 iZmtnMAmHkmTQ==
Date: Thu, 31 Oct 2024 19:02:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: George Guo <dongtai.guo@linux.dev>
Cc: horms@kernel.org, paul@paul-moore.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, George
 Guo <guodongtai@kylinos.cn>
Subject: Re: [PATCH net-next v2] netlabel: document doi_remove field of
 struct netlbl_calipso_ops
Message-ID: <20241031190206.475dbc4c@kernel.org>
In-Reply-To: <20241028123435.3495916-1-dongtai.guo@linux.dev>
References: <20241028123435.3495916-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 20:34:35 +0800 George Guo wrote:
> Add documentation of doi_remove field to Kernel doc for struct netlbl_calipso_ops.
> 
> Flagged by ./scripts/kernel-doc -none.

Okay but there are 5 other warnings in this file.
In the future please try to address all kdocs warnings in one change.

