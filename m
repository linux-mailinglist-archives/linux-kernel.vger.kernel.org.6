Return-Path: <linux-kernel+bounces-194647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 216C08D3F74
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 22:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B594D1F240AE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 20:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F68D1C68AD;
	Wed, 29 May 2024 20:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xy+Be0X9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BE515B963;
	Wed, 29 May 2024 20:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717013827; cv=none; b=kJ09zgxnQKA9k+rUPbJWn354DzenkNW5SdtTvRnDt58a+vhWMtCG2NsOW59rPQXdlTjTKK6OhqyACN3tn/WdKg+aclxiEwNUo7qlpOm/4cMRkeCy7lykTvEcaE/Yhgdyfol4ZZOQr2cQTEAS8BO2/1I8bVV81ze4dYoIS7HMwws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717013827; c=relaxed/simple;
	bh=croJmI7tdrUCnuq3nxQtEULazCqwtzJq0q4D/fdG+Iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QdDu06Q0Mxv7O8vvIW3XGk6hDdVniQybrbUCMKlUrUTEBwOUdXTvQFHCLW7vYZ76WCn165Rfe9QdC75IRMyeMqfYTicGlYl/+aklosmnhhdkRHi0jYGidEsRnflBNLL6xm0NqBVLDG4kAeUIIa1e6wPEskzBOCPE/KeKzx4HsYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xy+Be0X9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AADCC113CC;
	Wed, 29 May 2024 20:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717013827;
	bh=croJmI7tdrUCnuq3nxQtEULazCqwtzJq0q4D/fdG+Iw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xy+Be0X917eHFKsW7EL60JYBWKR2ebgfehQoYWQgmlws+bk2oeToAI4Z/C2BdFA4v
	 wYgNPqA4hAK2nnqUDr+IF9GhSxu6MNbz2vOJ3/xvavRzPCd33B73iFcZPVogc2HyoY
	 NyCSJulJScc7xQ/VN5DPx2AkjVDSxFeqRpIoh6kNVMlzFGt1KwGvtMl7OyUjoKVVZa
	 ghhGgRE3BncA7OXwFRYp+DPV6ruROloZ3t+uAmB4rzZb57VCdPgU5MazJ1m1Yyuiwq
	 fHMpGOWrUQwAz4Nh+txYJb0CM4VwyIpeRKxuawQW8rdKpt9EbgRTaYMHzp5K0D9G00
	 y7O9k30+ANGHQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5295eb47b48so177865e87.1;
        Wed, 29 May 2024 13:17:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1HJHcUDBrxdq+uyqilFbLSTgkAChtRniGX8+PkySQN1TSBgqpsci72dzcAvyitMF1ncIVHjdF8nD73FHIMBVdckY8fPaeoCzmDRpXe+uWnqrFCCxN8Bws1boWfRL28siAPECOiw/+mw==
X-Gm-Message-State: AOJu0YwkCa7RkN/Ishyfe0wBremIAiDGkyXF4QfeyijnhacwD5wdr8V/
	S1nrvMTxDg8Gmmlu5gPFThPape774LSGrgLQIE1PcWh/xpHO1on8WiI3hVF6wOZETD/S3MAdvP2
	TMRR425OXyjY/TNYVhfP3Vy2kiQ==
X-Google-Smtp-Source: AGHT+IH8HWoNFVqyKTq0rZ9W0bIDrLI8finr2ZKzQvyke9m79C4i0hxdDUr3JVPqEhZvq4zOQaBlEjJV7cXTXn2P5ag=
X-Received: by 2002:a05:6512:2025:b0:52b:2f78:9c92 with SMTP id
 2adb3069b0e04-52b7d419712mr139602e87.5.1717013825486; Wed, 29 May 2024
 13:17:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529073246.537459-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20240529073246.537459-1-alexander.stein@ew.tq-group.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 29 May 2024 15:16:53 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+QMnjadq6+eH11BxvxTy4vQmqScwOs6sgL3T2gY-mMsg@mail.gmail.com>
Message-ID: <CAL_Jsq+QMnjadq6+eH11BxvxTy4vQmqScwOs6sgL3T2gY-mMsg@mail.gmail.com>
Subject: Re: [PATCH 1/1] of: property: Fix device_node cleanup
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Saravana Kannan <saravanak@google.com>, Shresth Prasad <shresthprasad7@gmail.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 2:33=E2=80=AFAM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> '__free(device_node)' attached to remote will cause a double release:
> > OF: ERROR: of_node_release() detected bad of_node_put() on
> > /soc@0/bus@32c00000/dsi@32e60000
>
> In case remote is to be returned it must not be cleaned up by a call
> to of_node_put. The caller has to do that as the documentation mentions.
> Partly revert commit b94d24c08ee1a ("of: property: Remove calls to
> of_node_put") to fix it.
>
> Fixes: b94d24c08ee1 ("of: property: Remove calls to of_node_put")

I've dropped it now.

> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> I get the following trace starting with next-20240529:
>
> OF: ERROR: of_node_release() detected bad of_node_put() on /soc@0/bus@32c=
00000/dsi@32e60000
> CPU: 0 PID: 11 Comm: kworker/u16:0 Not tainted 6.10.0-rc1-next-20240529+ =
#2511 610eecbb638fc5fab9a27e01b78203e8a379a280
> Hardware name: TQ-Systems i.MX8MPlus TQMa8MPxL on MBa8MPxL (DT)
> Workqueue: events_unbound deferred_probe_work_func
> Call trace:
>  dump_backtrace+0x90/0x10c
>  show_stack+0x14/0x1c
>  dump_stack_lvl+0x6c/0x80
>  dump_stack+0x14/0x1c
>  of_node_release+0x11c/0x188
>  kobject_cleanup+0x48/0x17c
>  kobject_put+0x78/0xc0
>  of_node_put+0x14/0x20
>  drm_of_find_panel_or_bridge+0x84/0xd4
>  devm_drm_of_get_bridge+0x3c/0x8c
>  lcdif_attach_bridge+0x88/0x270
>  lcdif_load+0x144/0x28c
>  lcdif_probe+0x34/0xcc
>  platform_probe+0x64/0xe8
>  really_probe+0xc8/0x3ac
>  __driver_probe_device+0x84/0x188
>  driver_probe_device+0x38/0x150
>  __device_attach_driver+0xcc/0x194
>  bus_for_each_drv+0x80/0xdc
>  __device_attach+0x9c/0x1d0
>  device_initial_probe+0x10/0x18
>  bus_probe_device+0xa4/0xa8
>  deferred_probe_work_func+0x9c/0xe8
>  process_one_work+0x154/0x3fc
>  worker_thread+0x2f4/0x404
>  kthread+0xf4/0x100
>  ret_from_fork+0x10/0x20
> OF: ERROR: next of_node_put() on this node will result in a kobject warni=
ng 'refcount_t: underflow; use-after-free.'
> ------------[ cut here ]------------
> refcount_t: addition on 0; use-after-free.
> WARNING: CPU: 0 PID: 11 at lib/refcount.c:25 refcount_warn_saturate+0x150=
/0x214
> Modules linked in:
> CPU: 0 PID: 11 Comm: kworker/u16:0 Not tainted 6.10.0-rc1-next-20240529+ =
#2511 610eecbb638fc5fab9a27e01b78203e8a379a280
> Hardware name: TQ-Systems i.MX8MPlus TQMa8MPxL on MBa8MPxL (DT)
> [...]
>
>  drivers/of/property.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 83536216ed4fe..e5c6301643e4c 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -836,9 +836,7 @@ struct device_node *of_graph_get_remote_node(const st=
ruct device_node *node,
>  {
>         struct device_node *endpoint_node __free(device_node) =3D
>                             of_graph_get_endpoint_by_regs(node, port, end=
point);
> -
> -       struct device_node *remote __free(device_node) =3D
> -                           of_graph_get_remote_port_parent(endpoint_node=
);
> +       struct device_node *remote;
>
>         if (!endpoint_node) {
>                 pr_debug("no valid endpoint (%d, %d) for node %pOF\n",
> @@ -846,6 +844,7 @@ struct device_node *of_graph_get_remote_node(const st=
ruct device_node *node,
>                 return NULL;
>         }
>
> +       remote =3D of_graph_get_remote_port_parent(endpoint_node);
>         if (!remote) {
>                 pr_debug("no valid remote node\n");
>                 return NULL;
> @@ -853,6 +852,7 @@ struct device_node *of_graph_get_remote_node(const st=
ruct device_node *node,
>
>         if (!of_device_is_available(remote)) {
>                 pr_debug("not available for remote node\n");
> +               of_node_put(remote);
>                 return NULL;
>         }
>
> --
> 2.34.1
>

