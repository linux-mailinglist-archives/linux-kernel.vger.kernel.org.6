Return-Path: <linux-kernel+bounces-357961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C448A997889
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 00:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84217285011
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 22:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF9E1E1A1A;
	Wed,  9 Oct 2024 22:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uK6CFrCC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A275185949;
	Wed,  9 Oct 2024 22:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728513302; cv=none; b=mfg6CnrbCSqTaRwhp1aDXLWBAOuM6ZxCv9a8WlQbzNKuE+C7KImqI+rAxcY/TU6Ug6fUscie5dUKKhQHCU11IJ238DLvrBxori390/hCz+A9Qls0gCqdtoq+nO+xgYWmDfEpFOIBx1IBCd0VXitZ5FWkEZiJWz9HBwR8YzJage0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728513302; c=relaxed/simple;
	bh=KufRG1eI3wF+16cp8N6gZC57UtYmhCP4CAviqIFnAEI=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=rtWHhWx8dtoP+xREOyTnaaEmJ5RtWqtKhcqwDNBJK68tHVAjP1/uYG2soGDdhfi668CDapQM0Th2A6WNQQ3h58p9FOcwTehmrWhIzSC2Gn6Q7BLq0+yewSFiqrIAMPfxycRisPZDUVy06XC2/sJclXYH/nY8myM5P+HK23dU/aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uK6CFrCC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5B0C4CEC3;
	Wed,  9 Oct 2024 22:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728513302;
	bh=KufRG1eI3wF+16cp8N6gZC57UtYmhCP4CAviqIFnAEI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=uK6CFrCC2uAKy43YRCNASCWDr7u1xJXqjZvUwZ5ZJeGo8Qo+fjOPUOrKNzQ6CzV/u
	 4EgAobQZ2SHqoIayZjUYAQGAbkV4gatYSrxvWpfI32tZTlF5Jl5LFXTsmk1yjyysc9
	 Vm0+RkYZmDTE4h9UcMwK7+wm3Qp9Our+XhRU0DcGz2Vu8BUVojAAsa6HIy9ohNP9SD
	 gHjLCKiTuTznbomjEj+RK/ttSwIfna8Xuk88PDOz5KgaerffivkDOpFJa/50okOBQn
	 rC5KIjXYyR4joONnOb0/hBEYY1FnMiS52441B1do9xyz2VhPoKrxh8pgxFG0EFo92B
	 tKDCSjuBCQxKA==
Message-ID: <44cd09794e2db7b29c7ec176a4db055b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241009003552.254675-1-linux@treblig.org>
References: <20241009003552.254675-1-linux@treblig.org>
Subject: Re: [PATCH] clk: Remove unused clk_hw_rate_is_protected
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Dr. David Alan Gilbert <linux@treblig.org>
To: linux-clk@vger.kernel.org, linux@treblig.org, mturquette@baylibre.com
Date: Wed, 09 Oct 2024 15:34:59 -0700
User-Agent: alot/0.10

Quoting linux@treblig.org (2024-10-08 17:35:52)
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>=20
> clk_hw_rate_is_protected() was added in 2017's commit
> e55a839a7a1c ("clk: add clock protection mechanism to clk core")
>=20
> but has been unused.
>=20
> Remove it.
>=20
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---

Applied to clk-next

