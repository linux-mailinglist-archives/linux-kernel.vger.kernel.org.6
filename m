Return-Path: <linux-kernel+bounces-322197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B22639725A2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 01:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61D15284AFE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 23:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C43018DF7A;
	Mon,  9 Sep 2024 23:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1KU08Rz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BD98F5A;
	Mon,  9 Sep 2024 23:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725923621; cv=none; b=KX/BAsFy9FwiEyQ6iB/FEDCgNV3VjuxDSDDD/JiHVd+RGCsojyMuCsEFUj4RlABEke9Ks3mnIV4Za1zDSUPSMURZaFgYoEJnip3eJIQ/qUgZVPW4Mp4tGQpk7VjpZhFGQAYPMGnvF330gKt2XNaJtqp0Mdn413ZolFyq0ix7kaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725923621; c=relaxed/simple;
	bh=voaRQexsgqi637UtNBzxG1lAcobf7Q89NWHna/VDy5o=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=VU6z+gqCcjGhyLnW1JfjKD+1qW2Qn4ssqvJIkzBwiQzitiFSTT7msTt7Pvmu8W42ybwoi/qxTJnDM4rH0vTii2HA/ShFDYgOxhvLJwFFbm/J7SuNbFBq9bvj8iHIG1dRuz8KRXViMQtbe3oAbQYnHpRGflLbA/+RqwAFcfP16Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1KU08Rz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307E9C4CEC5;
	Mon,  9 Sep 2024 23:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725923621;
	bh=voaRQexsgqi637UtNBzxG1lAcobf7Q89NWHna/VDy5o=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=W1KU08Rz+KgB/ZGt0GC5+VPolQeXAcl7fzBaeHap0puKt0F5R7cWI3NsA2wxA1uWt
	 hEMf5yojJyxPtInNVFTEl4ju4KvWbSQNHPRzg6vo9ofzcxcRp/MIOqKtti/o91zTI1
	 nRiQeldT+znzjECXxu+autpEac14gQpDIbwhuu6fSrShFITWcQif+uZsjaenG8yVn9
	 hMVcKkpdZ5HoMI9qhRJ+x1XOWmsDvs6oIpCpIm0JZbG13HRjEOTfolV1q9wNcOyxgY
	 rFRhtvCl4GjTKcqA3i0lAqO2Qe43A4QutP5bnoIF7W6JdfhpuZ1zKy541aCXxQbnQf
	 AxshmVz9E+ViA==
Message-ID: <8073f2546b0395bb11113650f15dca79.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240909223149.85364-1-heiko@sntech.de>
References: <20240909223149.85364-1-heiko@sntech.de>
Subject: Re: [PATCH] dt-bindings: clock, reset: fix top-comment indentation rk3576 headers
From: Stephen Boyd <sboyd@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, detlev.casanova@collabora.com, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, mturquette@baylibre.com
Date: Mon, 09 Sep 2024 16:13:39 -0700
User-Agent: alot/0.10

Quoting Heiko Stuebner (2024-09-09 15:31:49)
> Block comments should align the * on each line, as checkpatch rightfully
> pointed out, so fix that style issue on the newly added rk3576 headers.
>=20
> Fixes: 49c04453db81 ("dt-bindings: clock, reset: Add support for rk3576")
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---

Applied to clk-next

