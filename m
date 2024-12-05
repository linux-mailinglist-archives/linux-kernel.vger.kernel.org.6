Return-Path: <linux-kernel+bounces-432949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0FD9E523F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3DF41882ABA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1541D8E07;
	Thu,  5 Dec 2024 10:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q27Aej/Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416F61D6DA1;
	Thu,  5 Dec 2024 10:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733394442; cv=none; b=tW0HTv8PZJaZUOCYUZAI9T49UbcSrwL/yAsvWl0C00hZ03Qv4nQfgNCRdmTaNbWbYSfQGqljQ1B3UhZp/Rwx3pJYyH+AABpNlLY33GUaVpqbN6wbmDrkkxKj88PRiep6wAUcXJypSoUYPOnuh/L+YtruuSR57cdi4aoQ/dIuRxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733394442; c=relaxed/simple;
	bh=idntvcQkf9t2f3WP3Hgoo58PIvf60jANTZQdagcW+D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYmnidSiD7h6D/vkAiyUZ5OfsMTDGskcCRqZZyoh7nkWuJuVIrV6zaj5y+pAXWzJiAzDechYi2fncZDbHPke/HzMTLHBWZe7F2J1ajeoYb4Mx84sLd+DoquZqkHDc5GKuVngyK5dzSw8i6LOrScyCo4YcJkgjVonk9WneJ9zGeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q27Aej/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68B8C4CED1;
	Thu,  5 Dec 2024 10:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733394441;
	bh=idntvcQkf9t2f3WP3Hgoo58PIvf60jANTZQdagcW+D8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q27Aej/YrhV9v+KqLBBz18KCX6GlXr8FfkOLKLHacs0FC3o/ibVNVO0b8gA26ZJPQ
	 kSC30TvCeRaIVj4r8Uxnt0QygL8gPF1JUMdubN9H1K2wyv2hAoQS8ocjhqONfm3+YH
	 DtB15FnOjLBerzfFQ4HLNyRXqW4F4T+jJU3MRuXlPoLqM9884l5DeOMjrXSZppjsPN
	 fgpUKcer9/cC6XZ92qgBoPXfa9dfthDgiZ67BUdcPuh1WQvMeb5UNy1nIyRS6eCZKh
	 tIZkqcw+tBM6fgtkOMHlo8puL6Q4UfwZHzZFegI/JhmiNH3ADz5t1FADeTEH8NXqub
	 RA1QtcC+7kKwQ==
Date: Thu, 5 Dec 2024 11:27:17 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
Cc: andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, quic_srichara@quicinc.com, quic_varada@quicinc.com
Subject: Re: [PATCH 1/2] dt-bindings: clock: qcom: gcc-ipq5424: remove
 apss_dbg clock macro
Message-ID: <vatyg3nkpillhyknyqe62myhmkp3nfbqwtltjcwfy2qhf4ez6j@iohbquyw6zsc>
References: <20241205064037.1960323-1-quic_mmanikan@quicinc.com>
 <20241205064037.1960323-2-quic_mmanikan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241205064037.1960323-2-quic_mmanikan@quicinc.com>

On Thu, Dec 05, 2024 at 12:10:36PM +0530, Manikanta Mylavarapu wrote:
> Since gcc_apss_dbg_clk has no consumers, the linux kernel will turn it
> off. This causes a kernel crash because this clock is access protected
> by trust zone. Therefore remove the gcc_apss_dbg_clk macro.
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
>  include/dt-bindings/clock/qcom,ipq5424-gcc.h | 1 -
>  1 file changed, 1 deletion(-)
>

You did not even build your patches... This fails to compile.

Best regards,
Krzysztof


